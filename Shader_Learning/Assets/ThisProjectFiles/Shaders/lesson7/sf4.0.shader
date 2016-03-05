Shader "Sbin/sf4.0" {//unity4.0没升5之前的surfaceShader结构
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		
	}
	SubShader {
		Tags { "RenderType"="Opaque"  "queue"="transparent" } //渲染类型是一个不透明的物体 
		LOD 200 //层级细节
		
		CGPROGRAM  //是代码块，表示下面是CG语法，到ENDCG结束
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert alpha
        //pragma编译指令 空格 surface关键词 surf是函数名称就是下面的void surf可随便起名 Standard光照模式 fullforwardshadows是阴影的选项
        //#pragma surface surfaceFunction lightModel [optionalparams]

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
        //上面注释的意思是使用shader model 3.0会得到一个更漂亮的光照，如果不写系统应该默认是2.0的，值越高代表可以使用更高的硬件功能

		sampler2D _MainTex;//变量声明 类型是 sampler2D 是二维纹理   代表上面的2D

		struct Input { //结构体 用于描述UV的坐标，实际也就是纹理坐标
			float2 uv_MainTex;  //必须以uv_  或  uv2_开头 而且是小写， 官方文档里有写  float3是3阶向量，是CG语言
		};

	

		void surf (Input IN, inout SurfaceOutput o) { //CG函数有返回值的  inout代表 既有输入也有输出，单独来个in是只有输入,out是输出。
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex); //tex2D是个函数，作用是使用一个纹理坐标进行采样，得到一个颜色。  fixed4 c声明一个颜色
			o.Albedo = c.rgb;//这个颜色取rgb值 交给输出结构体o的Albedo,描述漫反射中的颜色
			o.Alpha = c.a;//这个颜色的alpha交给输出结构体o的alpha
		}
		ENDCG
	}
	//FallBack "Diffuse" //如果删除fullforwardshadows就是删除阴影，可是有这句话的话还会自动加上阴影，要屏蔽这句话
}
