Shader "Sbin/vf" {
	
	SubShader {
	    Pass{ //要编写顶点和片段函数要有Pass通道
            CGPROGRAM //CG语言是镶嵌的代码段 ShaderLab会编译成正确的
            #pragma vertex vert   
            #pragma fragment frag
            //声明2个函数，好像2个函数都必须要编写  ，如果要写顶点和片段函数的话

            void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out float4 col:COLOR)   //:后面是语义，是顶点程序和片段程序能够被识别的这个变量的实际的意义。如果顶点程序要输出个POSITION语义的变量，那么这个变量必须是float44阶变量。
            {
                pos = float4(objPos,0,1);
                col = float4(0,0,1,1);
            }
            void frag(inout float4 col:COLOR)  //顶点程序对颜色输出了，在片段程序里不加处理直接输入再输出所以是inout
            {
                col = float4(0,1,0,1);
            }

            ENDCG
        }
	}
	
}
