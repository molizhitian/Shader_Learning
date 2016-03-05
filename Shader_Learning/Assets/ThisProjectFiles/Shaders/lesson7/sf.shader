Shader "Sbin/sf" {//surfaceShader 不需要Pass通道，他是对顶点和片段的包装，会生成相应代码包括Pass通道，如果加了Pass通道，会报错
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5//是浮点值，用于计算高光的光泽度
		_Metallic ("Metallic", Range(0,1)) = 0.0 //用于此材质表现的金属的光泽
	}
	SubShader {
		Tags { "RenderType"="Opaque" } //渲染类型是一个不透明的物体 
		LOD 200 //层级细节
		
		CGPROGRAM  //是代码块，表示下面是CG语法，到ENDCG结束
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows
        //pragma编译指令 空格 surface关键词 surf是函数名称就是下面的void surf可随便起名 Standard光照模式 fullforwardshadows是阴影的选项
        //#pragma surface surfaceFunction lightModel [optionalparams]

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
        //上面注释的意思是使用shader model 3.0会得到一个更漂亮的光照，如果不写系统应该默认是2.0的，值越高代表可以使用更高的硬件功能

		sampler2D _MainTex;//变量声明 类型是 sampler2D 是二维纹理   代表上面的2D

		struct Input { //结构体 用于描述UV的坐标，实际也就是纹理坐标
			float2 uv_MainTex;  //必须以uv_  或  uv2_开头 而且是小写， 官方文档里有写  float3是3阶向量，是CG语言
		};

		half _Glossiness;//上面声明了一遍，在CGPROGRAM里还要再声明一遍 half 是浮点值
		half _Metallic;
		fixed4 _Color; //4阶向量， 代表上面的Color 

		void surf (Input IN, inout SurfaceOutputStandard o) { //CG函数有返回值的  inout代表 既有输入也有输出，单独来个in是只有输入,out是输出。
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color; //tex2D是个函数，作用是使用一个纹理坐标进行采样，得到一个颜色。  fixed4 c声明一个颜色
			o.Albedo = c.rgb;//这个颜色取rgb值 交给输出结构体o的Albedo,描述漫反射中的颜色
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;//这个颜色的alpha交给输出结构体o的alpha
		}
		ENDCG
	}
	FallBack "Diffuse"
}
