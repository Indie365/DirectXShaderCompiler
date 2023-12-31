// RUN: %dxc -T vs_6_0 -E main

// According to HLSL reference:
// The components of the vectors may be either float or int.

void main() {
    // CHECK:      [[a:%\d+]] = OpLoad %int %a
    // CHECK-NEXT: [[b:%\d+]] = OpLoad %int %b
    // CHECK-NEXT: [[intdot1:%\d+]] = OpIMul %int [[a]] [[b]]
    // CHECK-NEXT: OpStore %c [[intdot1]]
    int1 a, b;
    int c;
    c = dot(a, b);

    // CHECK:      [[d:%\d+]] = OpLoad %v2int %d
    // CHECK-NEXT: [[e:%\d+]] = OpLoad %v2int %e
    // CHECK-NEXT: [[d0:%\d+]] = OpCompositeExtract %int [[d]] 0
    // CHECK-NEXT: [[e0:%\d+]] = OpCompositeExtract %int [[e]] 0
    // CHECK-NEXT: [[mul_de0:%\d+]] = OpIMul %int [[d0]] [[e0]]
    // CHECK-NEXT: [[d1:%\d+]] = OpCompositeExtract %int [[d]] 1
    // CHECK-NEXT: [[e1:%\d+]] = OpCompositeExtract %int [[e]] 1
    // CHECK-NEXT: [[mul_de1:%\d+]] = OpIMul %int [[d1]] [[e1]]
    // CHECK-NEXT: [[intdot2:%\d+]] = OpIAdd %int [[mul_de0]] [[mul_de1]]
    // CHECK-NEXT: OpStore %f [[intdot2]]
    int2 d, e;
    int f;
    f = dot(d, e);

    // CHECK:      [[g:%\d+]] = OpLoad %v3int %g
    // CHECK-NEXT: [[h:%\d+]] = OpLoad %v3int %h
    // CHECK-NEXT: [[g0:%\d+]] = OpCompositeExtract %int [[g]] 0
    // CHECK-NEXT: [[h0:%\d+]] = OpCompositeExtract %int [[h]] 0
    // CHECK-NEXT: [[mul_gh0:%\d+]] = OpIMul %int [[g0]] [[h0]]
    // CHECK-NEXT: [[g1:%\d+]] = OpCompositeExtract %int [[g]] 1
    // CHECK-NEXT: [[h1:%\d+]] = OpCompositeExtract %int [[h]] 1
    // CHECK-NEXT: [[mul_gh1:%\d+]] = OpIMul %int [[g1]] [[h1]]
    // CHECK-NEXT: [[g2:%\d+]] = OpCompositeExtract %int [[g]] 2
    // CHECK-NEXT: [[h2:%\d+]] = OpCompositeExtract %int [[h]] 2
    // CHECK-NEXT: [[mul_gh2:%\d+]] = OpIMul %int [[g2]] [[h2]]
    // CHECK-NEXT: [[intdot3_add0:%\d+]] = OpIAdd %int [[mul_gh0]] [[mul_gh1]]
    // CHECK-NEXT: [[intdot3:%\d+]] = OpIAdd %int [[intdot3_add0]] [[mul_gh2]]
    // CHECK-NEXT: OpStore %i [[intdot3]]
    int3 g, h;
    int i;
    i = dot(g, h);

    // CHECK:      [[j:%\d+]] = OpLoad %v4int %j
    // CHECK-NEXT: [[k:%\d+]] = OpLoad %v4int %k
    // CHECK-NEXT: [[j0:%\d+]] = OpCompositeExtract %int [[j]] 0
    // CHECK-NEXT: [[k0:%\d+]] = OpCompositeExtract %int [[k]] 0
    // CHECK-NEXT: [[mul_jk0:%\d+]] = OpIMul %int [[j0]] [[k0]]
    // CHECK-NEXT: [[j1:%\d+]] = OpCompositeExtract %int [[j]] 1
    // CHECK-NEXT: [[k1:%\d+]] = OpCompositeExtract %int [[k]] 1
    // CHECK-NEXT: [[mul_jk1:%\d+]] = OpIMul %int [[j1]] [[k1]]
    // CHECK-NEXT: [[j2:%\d+]] = OpCompositeExtract %int [[j]] 2
    // CHECK-NEXT: [[k2:%\d+]] = OpCompositeExtract %int [[k]] 2
    // CHECK-NEXT: [[mul_jk2:%\d+]] = OpIMul %int [[j2]] [[k2]]
    // CHECK-NEXT: [[j3:%\d+]] = OpCompositeExtract %int [[j]] 3
    // CHECK-NEXT: [[k3:%\d+]] = OpCompositeExtract %int [[k]] 3
    // CHECK-NEXT: [[mul_jk3:%\d+]] = OpIMul %int [[j3]] [[k3]]
    // CHECK-NEXT: [[intdot4_add0:%\d+]] = OpIAdd %int [[mul_jk0]] [[mul_jk1]]
    // CHECK-NEXT: [[intdot4_add1:%\d+]] = OpIAdd %int [[intdot4_add0]] [[mul_jk2]]
    // CHECK-NEXT: [[intdot4:%\d+]] = OpIAdd %int [[intdot4_add1]] [[mul_jk3]]
    // CHECK-NEXT: OpStore %l [[intdot4]]
    int4 j, k;
    int l;
    l = dot(j, k);

    // CHECK:      [[m:%\d+]] = OpLoad %float %m
    // CHECK-NEXT: [[n:%\d+]] = OpLoad %float %n
    // CHECK-NEXT: [[floatdot1:%\d+]] = OpFMul %float [[m]] [[n]]
    // CHECK-NEXT: OpStore %o [[floatdot1]]
    float1 m, n;
    float o;
    o = dot(m, n);

    // CHECK:      [[p:%\d+]] = OpLoad %v2float %p
    // CHECK-NEXT: [[q:%\d+]] = OpLoad %v2float %q
    // CHECK-NEXT: [[floatdot2:%\d+]] = OpDot %float [[p]] [[q]]
    // CHECK-NEXT: OpStore %r [[floatdot2]]
    float2 p, q;
    float r;
    r = dot(p, q);

    // CHECK:      [[s:%\d+]] = OpLoad %v3float %s
    // CHECK-NEXT: [[t:%\d+]] = OpLoad %v3float %t
    // CHECK-NEXT: [[floatdot3:%\d+]] = OpDot %float [[s]] [[t]]
    // CHECK-NEXT: OpStore %u [[floatdot3]]
    float3 s, t;
    float u;
    u = dot(s, t);

    // CHECK:      [[v:%\d+]] = OpLoad %v4float %v
    // CHECK-NEXT: [[w:%\d+]] = OpLoad %v4float %w
    // CHECK-NEXT: [[floatdot4:%\d+]] = OpDot %float [[v]] [[w]]
    // CHECK-NEXT: OpStore %x [[floatdot4]]
    float4 v, w;
    float x;
    x = dot(v, w);

    // CHECK:      [[ua:%\d+]] = OpLoad %uint %ua
    // CHECK-NEXT: [[ub:%\d+]] = OpLoad %uint %ub
    // CHECK-NEXT: [[uintdot1:%\d+]] = OpIMul %uint [[ua]] [[ub]]
    // CHECK-NEXT: OpStore %uc [[uintdot1]]
    uint1 ua, ub;
    uint uc;
    uc = dot(ua, ub);

    // CHECK:      [[ud:%\d+]] = OpLoad %v2uint %ud
    // CHECK-NEXT: [[ue:%\d+]] = OpLoad %v2uint %ue
    // CHECK-NEXT: [[ud0:%\d+]] = OpCompositeExtract %uint [[ud]] 0
    // CHECK-NEXT: [[ue0:%\d+]] = OpCompositeExtract %uint [[ue]] 0
    // CHECK-NEXT: [[mul_ude0:%\d+]] = OpIMul %uint [[ud0]] [[ue0]]
    // CHECK-NEXT: [[ud1:%\d+]] = OpCompositeExtract %uint [[ud]] 1
    // CHECK-NEXT: [[ue1:%\d+]] = OpCompositeExtract %uint [[ue]] 1
    // CHECK-NEXT: [[mul_ude1:%\d+]] = OpIMul %uint [[ud1]] [[ue1]]
    // CHECK-NEXT: [[uintdot2:%\d+]] = OpIAdd %uint [[mul_ude0]] [[mul_ude1]]
    // CHECK-NEXT: OpStore %uf [[uintdot2]]
    uint2 ud, ue;
    uint uf;
    uf = dot(ud, ue);

    // CHECK:      [[ug:%\d+]] = OpLoad %v3uint %ug
    // CHECK-NEXT: [[uh:%\d+]] = OpLoad %v3uint %uh
    // CHECK-NEXT: [[ug0:%\d+]] = OpCompositeExtract %uint [[ug]] 0
    // CHECK-NEXT: [[uh0:%\d+]] = OpCompositeExtract %uint [[uh]] 0
    // CHECK-NEXT: [[mul_ugh0:%\d+]] = OpIMul %uint [[ug0]] [[uh0]]
    // CHECK-NEXT: [[ug1:%\d+]] = OpCompositeExtract %uint [[ug]] 1
    // CHECK-NEXT: [[uh1:%\d+]] = OpCompositeExtract %uint [[uh]] 1
    // CHECK-NEXT: [[mul_ugh1:%\d+]] = OpIMul %uint [[ug1]] [[uh1]]
    // CHECK-NEXT: [[ug2:%\d+]] = OpCompositeExtract %uint [[ug]] 2
    // CHECK-NEXT: [[uh2:%\d+]] = OpCompositeExtract %uint [[uh]] 2
    // CHECK-NEXT: [[mul_ugh2:%\d+]] = OpIMul %uint [[ug2]] [[uh2]]
    // CHECK-NEXT: [[uintdot3_add0:%\d+]] = OpIAdd %uint [[mul_ugh0]] [[mul_ugh1]]
    // CHECK-NEXT: [[uintdot3:%\d+]] = OpIAdd %uint [[uintdot3_add0]] [[mul_ugh2]]
    // CHECK-NEXT: OpStore %ui [[uintdot3]]
    uint3 ug, uh;
    uint ui;
    ui = dot(ug, uh);

    // CHECK:      [[uj:%\d+]] = OpLoad %v4uint %uj
    // CHECK-NEXT: [[uk:%\d+]] = OpLoad %v4uint %uk
    // CHECK-NEXT: [[uj0:%\d+]] = OpCompositeExtract %uint [[uj]] 0
    // CHECK-NEXT: [[uk0:%\d+]] = OpCompositeExtract %uint [[uk]] 0
    // CHECK-NEXT: [[mul_ujk0:%\d+]] = OpIMul %uint [[uj0]] [[uk0]]
    // CHECK-NEXT: [[uj1:%\d+]] = OpCompositeExtract %uint [[uj]] 1
    // CHECK-NEXT: [[uk1:%\d+]] = OpCompositeExtract %uint [[uk]] 1
    // CHECK-NEXT: [[mul_ujk1:%\d+]] = OpIMul %uint [[uj1]] [[uk1]]
    // CHECK-NEXT: [[uj2:%\d+]] = OpCompositeExtract %uint [[uj]] 2
    // CHECK-NEXT: [[uk2:%\d+]] = OpCompositeExtract %uint [[uk]] 2
    // CHECK-NEXT: [[mul_ujk2:%\d+]] = OpIMul %uint [[uj2]] [[uk2]]
    // CHECK-NEXT: [[uj3:%\d+]] = OpCompositeExtract %uint [[uj]] 3
    // CHECK-NEXT: [[uk3:%\d+]] = OpCompositeExtract %uint [[uk]] 3
    // CHECK-NEXT: [[mul_ujk3:%\d+]] = OpIMul %uint [[uj3]] [[uk3]]
    // CHECK-NEXT: [[uintdot4_add0:%\d+]] = OpIAdd %uint [[mul_ujk0]] [[mul_ujk1]]
    // CHECK-NEXT: [[uintdot4_add1:%\d+]] = OpIAdd %uint [[uintdot4_add0]] [[mul_ujk2]]
    // CHECK-NEXT: [[uintdot4:%\d+]] = OpIAdd %uint [[uintdot4_add1]] [[mul_ujk3]]
    // CHECK-NEXT: OpStore %ul [[uintdot4]]
    uint4 uj, uk;
    uint ul;
    ul = dot(uj, uk);

    // CHECK:      OpCompositeConstruct %v3float %float_1 %float_1 %float_1
    // CHECK-NEXT: OpDot %float
    float3 f3;
    float dotProductByLiteral = dot(f3, float3(1.0.xxx));
   
    // A dot product using `half` should get promoted to `float`. 
    // CHECK:      OpCompositeConstruct %v3float %float_1 %float_1 %float_1
    // CHECK-NEXT: OpDot %float
    half3 h3;
    half dotProductWithHalf = dot(h3, half3(1.0.xxx));
}
