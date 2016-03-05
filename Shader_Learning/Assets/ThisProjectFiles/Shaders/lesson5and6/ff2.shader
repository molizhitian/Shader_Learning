Shader "Sbin/ff2" {

	  Properties{
        _Color ("Main Color", Color) = (1,1,1,1)
        //_Color ("Main Color", Color) = (1,.5,.5,1)
        _Ambient("Ambient", Color) = (0.3,0.3,0.3,0.3) //默认环境光的值
        _Specular("Specular", Color) = (1,1,1,1) //控制高光
        _Shininess("Shininess",Range(0,8)) = 4  //默认是4，可以是float；如果说越光滑的物体,说明值越高反光点越集中，越不光滑的物体，说明值越低，反光高光部分就越大
        _Emission("Emission", Color) = (1,1,1,1)   //自发光
        _MainTex("MainTex",2D) = ""{}  //官方都是 = "while"{texgen objectlinear}，指的是纹理混合。如果 不愿意写{} 可以把下面的 _Constant("ConstantColor" , Color) = (1,1,1,0.3)放到这两句上面去声明，也不会报错。
        _SecondTex("SecondTex",2D) = ""{}  
        _Constant("ConstantColor" , Color) = (1,1,1,0.3)
    }
	SubShader {
    //这是fix function shader 固定管线shader

        Tags { "Quene" = "Transparent"} //因为unity在渲染正常的几何体的时候是按默认顺序渲染的，如果想要半透明的效果要加这句，在默认渲染顺序以后加入的意思。这里跟老师讲的不一样，不加这句也半透明了。
        
		Pass{//PASS通道渲染
    //        Color(1,0,0,1)//红，绿，蓝，Alpha
            //Color[_Color]//要想使用上面的属性把小括号改为中括号，中括号代表的是它是一个参数值，而不是一个固定值。但这个是纯色的，没有明暗变化，如果要引入光照看下面

            Blend SrcAlpha OneMinusSrcAlpha //用1减去源的alpha值，效果是用当前渲染物体颜色中的alpha值与1剪掉当前颜色中的alpha值的 比率？去混合之前的已经被渲染好的场景颜色值，有了这句会有点透明，但不会真正的达到透明效果，这是因为在
                                                //在unity引擎中存在一个渲染顺序的东西，就是指的是图形显卡当渲染某一帧的时候，因为场景当中有很多的物体，我们到底是先渲染哪一个，后渲染哪一个，要取决于渲染顺序。
                                                //后面的物体先渲染，前面的物体后渲染，如果要让前面的球体透明看到后面的球体，就要改变渲染次序。
            Material{//引入光照，漫反射
                Diffuse[_Color]
                Ambient[_Ambient]//控制环境光的影响，好像只影响背光，不影响高光
                SPECULAR[_Specular]//控制高光
                Shininess[_Shininess]  //是浮点值，用这个命令去描述SPECULAR到底有多强，用他来控制我们的镜面反射过程中高光的区域
                Emission[_Emission]   //不依赖外部光照，也能自己发光
            }//但是单单这样设置是并不管用的，因为没有开启光照
            Lighting On    //开光 关光是Off
            SeparateSpecular On //因为是固定管线Shader，所以要加这句。独立的镜面的高光，像镜子一样在很集中的地方进行反光的。对很光滑的物体

            SetTexture[_MainTex]{//使用贴图得用的命令，一个SetTexture只能带上一个参数，如果需要混合2张或2张以上的纹理，需要继续填写Texture
                
                //Combine命令后面没有小括号和中括号直接有个空格，此命令本意是合并
                //primary是fix function shader中固定的关键词，代表了前面所有计算了材质和光照以后的颜色
                Combine texture * primary double   //因为texture RGBA 0到1 是小数  primary 是颜色也是小数 相乘后会成为更小的数  整体颜色会变深，所以有个double 是乘以2的意思 也就会提高2倍的亮度
                //quad是4倍，替换double的话
            }  

            //SetTexture[_SecondTex]
            //{
            //    //Combine命令总是用当前纹理混合前面的光照信息。
            //    Combine texture * previous double  //由primary改成previous，previous代表先前的所有计算和采样的结果,primary代表 Material下面到SetTexture上面
            //}  
            //SetTexture也不能无限混合，要根据硬件的条件，基本2张混合是没问题的

            SetTexture[_SecondTex]
            {
                ConstantColor[_Constant]
                
                //Combine texture * previous double , texture  //如果想用贴图上的alpha通道，用贴图上的alpha，当加入这个,texture的时候，就表示只是取了贴图的alpha通道，而且只会取这个贴图的alpha部分进行运算，而之前所有的alpha值失效
                                                            //加了,texture后，要把贴图的Alpha from Grayscal打勾，这是灰度系数。这样球体也会透明的
                        
                Combine texture * previous double , texture * constant //直接乘constant，使用ConstantColor的时候是乘constant。是用0.3的alpha值乘以纹理的，这样会更透
                                                            //乘了constant 就可以把texture的Alpha from Grayscal勾去掉，单纯的用constant的alpha值控制透明度
            }  

        }

        //ShaderLab:Blending 
        //SrcFactor源的部分   DstFactor目标的部分
        //举个例子，当我们渲染当前这个球体的时候，渲染这个球体得到的颜色叫做源，而球体以外还有其他的物体包括天空盒，他们已经在我们渲染这个物体之前已经被渲染过了，所以他们叫做目标。
	} 
}
