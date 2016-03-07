Shader "Sbin/vf12" {
	
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

                if(pos.x<0)



                col = pos; //虽然语义不同，但是类型相同时可以赋值的.Cube里的模型信息里存的是 x-0.5 +0.5 y -0.5 +0.5 的  所以颜色就是能分析出来的。
            }
            void frag(inout float4 col:COLOR)  //顶点程序对颜色输出了，在片段程序里不加处理直接输入再输出所以是inout
            {
                //col = float4(0,1,0,1);
                
                //int i = 1;  //老师的i=1走的是default值，我的却是case 1。所以以后不要用switch。用分支就用if else
                ////switch case CG是保留的，但是是不被支持的，也就是程序里可以用
                //switch(i)
                //{
                //    case 0:
                //        col = float4(1,0,0,1);
                //        break;
                //    case 1:
                //        col = float4(0,1,0,1);
                //        break;
                //    default:
                //        col = float4(0,0,1,1);
                //        break;
                //}


            }
			
            ENDCG
        }
	}
	
}
