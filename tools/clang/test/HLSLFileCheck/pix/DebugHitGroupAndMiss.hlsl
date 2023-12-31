// RUN: %dxc -T lib_6_3 %s | %opt -S -hlsl-dxil-debug-instrumentation,parameter0=10,parameter1=20,parameter2=30 | %FileCheck %s


// Just check that the selection prolog was added to each shader:

// CHECK: call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 0)
// CHECK: call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 1)
// CHECK: call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 2)
// CHECK: call i32 @dx.op.dispatchRaysIndex.i32(i32 145, i8 0)

// There must be three compares:
// CHECK: = icmp eq i32
// CHECK: = icmp eq i32
// CHECK: = icmp eq i32

// Two ANDs of these bools:
// CHECK: and i1
// CHECK: and i1

//-----------------------------------------------------------------------------
struct cb_push_test_raytracing_t
{
    uint m_rt_index;
    uint m_raytracing_acc_struct_index;
    uint m_per_view_index;
};

//-----------------------------------------------------------------------------
struct cb_view_t
{
    float4x4 m_view;
    float4x4 m_proj;
    float4x4 m_inv_view_proj;
    float3   m_camera_pos;
};

RaytracingAccelerationStructure g_bindless_raytracing_acc_struct[] : register(t0, space200);
ConstantBuffer<cb_push_test_raytracing_t> g_push_constants : register(b0, space999);
ConstantBuffer<cb_view_t> g_view[] : register(b0, space100);
RWTexture2D<float4> g_output[] : register(u0, space100);

//-----------------------------------------------------------------------------
// Payloads
//-----------------------------------------------------------------------------

struct ray_payload_t
{
    float3 m_color;
};

//-----------------------------------------------------------------------------
// Ray generation
//-----------------------------------------------------------------------------

[shader("raygeneration")]
void raygen_shader()
{
    if( g_push_constants.m_rt_index != 0xFFFFFFFF &&
        g_push_constants.m_raytracing_acc_struct_index != 0xFFFFFFFF &&
        g_push_constants.m_per_view_index != 0xFFFFFFFF)
    {
        RaytracingAccelerationStructure l_acc_struct = g_bindless_raytracing_acc_struct[g_push_constants.m_raytracing_acc_struct_index];
        RWTexture2D<float4> l_output = g_output[g_push_constants.m_rt_index];
        cb_view_t l_per_view = g_view[g_push_constants.m_per_view_index];

        uint3 l_launch_index = DispatchRaysIndex();

        // Ray dsc
        RayDesc ray;
        ray.Origin      = l_per_view.m_camera_pos; // THIS LINE CAUSES AN ACCESS VIOLATION. Replacing l_per_view.m_camera_pos with a constant makes it compile fine
        //ray.Origin      = 0;
        ray.Direction   = float3(0, 1.0, 0);
        ray.TMin        = 0;
        ray.TMax        = 100000;

        ray_payload_t l_payload;
        TraceRay(l_acc_struct, 0 /*rayFlags*/, 0xFF, 0 /* ray index*/, 0, 0, ray, l_payload);
        l_output[l_launch_index.xy] = float4(l_payload.m_color, 1.0);
    }
}

//-----------------------------------------------------------------------------
// Primary rays
//-----------------------------------------------------------------------------

[shader("miss")]
void miss_shader(inout ray_payload_t l_payload)
{
    l_payload.m_color = float3(0.4, 0.0, 0.0);
}

[shader("closesthit")]
void closest_hit_shader(inout ray_payload_t l_payload, in BuiltInTriangleIntersectionAttributes l_attribs)
{
    l_payload.m_color = 1.0f;
}


struct MyAttributes {
  float2 bary;
  uint id;
};

[shader("intersection")]
void intersection1()
{
  float hitT = RayTCurrent();
  MyAttributes attr = (MyAttributes)0;
  bool bReported = ReportHit(hitT, 0, attr);
}
