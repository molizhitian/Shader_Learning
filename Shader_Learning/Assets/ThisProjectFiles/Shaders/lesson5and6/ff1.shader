Shader "Sbin/ff1" {
	
    Properties{
        _Color ("Main Color", Color) = (1,1,1,1)
        //_Color ("Main Color", Color) = (1,.5,.5,1)
        _Ambient("Ambient", Color) = (0.3,0.3,0.3,0.3) //默认环境光的值
        _Specular("Specular", Color) = (1,1,1,1) //控制高光
        _Shininess("Shininess",Range(0,8)) = 4  //默认是4，可以是float；如果说越光滑的物体,说明值越高反光点越集中，越不光滑的物体，说明值越低，反光高光部分就越大
        _Emission("Emission", Color) = (1,1,1,1)   //自发光
    }
	SubShader {
    //这是fix function shader 固定管线shader

		Pass{//PASS通道渲染
    //        Color(1,0,0,1)//红，绿，蓝，Alpha
            //Color[_Color]//要想使用上面的属性把小括号改为中括号，中括号代表的是它是一个参数值，而不是一个固定值。但这个是纯色的，没有明暗变化，如果要引入光照看下面

            Material{//引入光照，漫反射
                Diffuse[_Color]
                Ambient[_Ambient]//控制环境光的影响，好像只影响背光，不影响高光
                SPECULAR[_Specular]//控制高光
                Shininess[_Shininess]  //是浮点值，用这个命令去描述SPECULAR到底有多强，用他来控制我们的镜面反射过程中高光的区域
                Emission[_Emission]   //不依赖外部光照，也能自己发光
            }//但是单单这样设置是并不管用的，因为没有开启光照
            Lighting On    //开光 关光是Off
            SeparateSpecular On //因为是固定管线Shader，所以要加这句。独立的镜面的高光，像镜子一样在很集中的地方进行反光的。对很光滑的物体
        }
	} 
	
}