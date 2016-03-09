Shader "Sbin/vf13" {
	
	SubShader {
	    Pass{ //要编写顶点和片段函数要有Pass通道
            CGPROGRAM //CG语言是镶嵌的代码段 ShaderLab会编译成正确的
// Upgrade NOTE: excluded shader from DX11, Xbox360, OpenGL ES 2.0 because it uses unsized arrays
#pragma exclude_renderers d3d11 xbox360 gles
        
            #pragma vertex vert   
            #pragma fragment frag
            //声明2个函数，好像2个函数都必须要编写  ，如果要写顶点和片段函数的话

            //void Func(out float4 c);//如果非要放在下面，要用C语言的前项声明，这么写

            #include "sbin/sbin.cginc" 
            //#include "sbin\sbin.cginc"  这个\也是可以的
            //#include "sbin\\\///\/sbin.cginc"  甚至这都可以
            //使用cg的include指令，把函数包含进来，就可以直接用了

//            float Func2(float arr[2])//arr[]，这样不行，必须制定维度arr[2]
//            {
//                float sum=0;//必须初始化
//                for(int i=0;i<arr.Length;i++)
//                {
//                    sum+=arr[i]; 
//                }
//                return sum;//老师的就会正确
//            }


            void vert(in float2 objPos:POSITION,out float4 pos:POSITION,out float4 col:COLOR)   //:后面是语义，是顶点程序和片段程序能够被识别的这个变量的实际的意义。如果顶点程序要输出个POSITION语义的变量，那么这个变量必须是float44阶变量。
            {
                pos = float4(objPos,0,1); //CVV裁剪，Cube是-0.5到0.5的 所以永远都是一半，因为屏幕是从-1到1的
               
                col = pos;
            }

            //void Func()
            //{
            //}

            void frag(inout float4 col:COLOR)  //顶点程序对颜色输出了，在片段程序里不加处理直接输入再输出所以是inout
            {
                //Func(col);    
                float arr[] = {0.5,0.5};  //0.5x是fixed，0.5h是half，0.5f是float,不带是float
                col.x = Func2(arr);


            }

			//在C语言中，要使用函数，得先定义，所以放到后面就不行了，得放到前面
//            void Func(out float4 c)//CG语言，是值拷贝，没有指针。所以要想输出要加out
//            {
//                c = float4(0,1,0,1);
//            }

            ENDCG
        }
	}
	
}
