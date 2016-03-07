Shader "Sbin/vf2" {
	
	SubShader {
	    Pass{ //要编写顶点和片段函数要有Pass通道
            CGPROGRAM //CG语言是镶嵌的代码段 ShaderLab会编译成正确的
// Upgrade NOTE: excluded shader from DX11 and Xbox360; has structs without semantics (struct v2f members pos,uv)
#pragma exclude_renderers d3d11 xbox360
// Upgrade NOTE: excluded shader from OpenGL ES 2.0 because it uses non-square matrices
#pragma exclude_renderers gles
            #pragma vertex vert   
            #pragma fragment frag
            #define MACROFL FL4(fl4.ab,fl3.zy); 
            //C语言支持宏定义，CG也支持
            //声明2个函数，好像2个函数都必须要编写  ，如果要写顶点和片段函数的话

            //C语言中，可以为某个类型指定类型别名，CG也可以
            typedef float4 FL4;//声明类型别名

            struct v2f{ //结构体
                float4 pos;
                float2 uv;
            };



            void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out float4 col:COLOR)   //:后面是语义，是顶点程序和片段程序能够被识别的这个变量的实际的意义。如果顶点程序要输出个POSITION语义的变量，那么这个变量必须是float44阶变量。
            {
                pos = float4(objPos,0,1); //CVV裁剪，Cube是-0.5到0.5的 所以永远都是一半，因为屏幕是从-1到1的
                //col = float4(0,0,1,1);
                col = pos; //虽然语义不同，但是类型相同时可以赋值的.Cube里的模型信息里存的是 x-0.5 +0.5 y -0.5 +0.5 的  所以颜色就是能分析出来的。
            }
            void frag(inout float4 col:COLOR)  //顶点程序对颜色输出了，在片段程序里不加处理直接输入再输出所以是inout
            {
                //col = float4(0,1,0,1);

                //float r = 1;  //float 是 32位精度浮点值，half是16位精度浮点值
                //float g = 0;
                //float b = 0;
                //float a = 1;

                //half r = 1;  //float 是 32位精度浮点值，half是16位精度浮点值
                //half g = 0;
                //half b = 0;
                //half a = 1;

                fixed r = 1;  //float 是 32位精度浮点值，half是16位精度浮点值，fixed是一个定点数？ 这些都是基本类型
                fixed g = 0;
                fixed b = 0;
                fixed a = 1;   //这些都是向量  也就是 fixed1 = fixed

                //CG也有bool类型，int类型

                col = fixed4(r,g,b,a);//The fixed data type corresponds to a native signed 9-bit integers normalized to the [-1.0,+1.0] range.
                //fixed是2的8次方 256 个变化，所以用于颜色足够用了，所以对颜色最优化的用啊是fixed
                
                bool bl = false; //bool也是基本类型

                col = bl?col:fixed4(0,1,0,1);


                float2 fl2 = float2(1,0);
                float3 fl3 = float3(1,0,1);
                float4 fl4 = float4(1,1,0,1);

                //float4 fl = float4(f12,0,1); //可以这么做
                //float4 fl = float4(fl2.xy,0,1);  //有些时候会去数据的分量上取值，就这么做。这种操作就是Swizzle操作，对于swizzle操作，分量可以是xyzw,或者rgba

                //float4 fl = float4(fl2.yx,0,1);  //swizzle操作比较灵活，可以颠倒顺序
                //float4 fl = float4(fl4.wzyx);//最体现swizzle操作的来了
                //float4 fl = float4(fl3.xyzz);//xyzw是不可以的，但是可以重复已有的分量
                //float4 fl = float4(fl4.rgba);//xyzw可以用，rgba也可以，但不可以xyba
                //FL4 fl = float4(fl4.ab,fl3.zy);//还可以这么取，使用类型别名
                FL4 fl = MACROFL//使用宏
                col = fl;//CG也支持类型转换，由高精度到低精度或做个隐含的截取


                float2x2 M2x2 = {1,0, 1,1};  //声明一个矩阵，  2x2是2行2列的矩阵，基本数据类型是float
                //float2x4 M2x4 = {0,0,1,1 ,0,1,0,1};  //声明一个矩阵，  2x4是2行4列的矩阵，基本数据类型是float
                //float2x4 M2x4 = { {0,0,1,1} ,{0,1,0,1} };  //也可以这么写
                float2x4 M2x4 = { fl4 ,{0,1,0,1} };  //也可以这么写

                col = M2x4[0];//取索引就是取哪一行

                float arr[4] = {1,0.5,0.5,1}; //这是CG语言的数组跟C语言一样的
                col = float4(arr[0],arr[1],arr[2],arr[3]); //数组要这么用，其他用法不可以


                v2f o;//使用结构体
                o.pos = fl4;
                o.uv = fl2;

            }
			
            ENDCG
        }
	}
	
}
