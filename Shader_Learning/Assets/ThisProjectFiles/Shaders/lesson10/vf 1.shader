Shader "Sbin/vf1" {
	
	SubShader {
	    Pass{ //要编写顶点和片段函数要有Pass通道
            CGPROGRAM //CG语言是镶嵌的代码段 ShaderLab会编译成正确的
            #pragma vertex vert   
            #pragma fragment frag
            //声明2个函数，好像2个函数都必须要编写  ，如果要写顶点和片段函数的话

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
            }
			
            ENDCG
        }
	}
	
}
