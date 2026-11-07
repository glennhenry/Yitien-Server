package com.yiTian.net.handler
{
   import com.yiTian.data.model.Model_HuangzhuanZP;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.call.Delegate123;
   import com.yiTian.view.modules.huangzhuanZP.Icon_Huangzhuan;
   import com.yiTian.view.modules.huangzhuanZP.View_HuangzhuanZP;
   import com.yiTian.view.modules.huangzhuanZP.Vo_HuangzhuanZP;
   
   public class HuangzhuanZPHandler
   {
      
      public function HuangzhuanZPHandler()
      {
         super();
      }
      
      public static function GC_HZZP_OPENWIN(shengYu:int, award_data:String, vecPlayVo:Vector.<Vo_HuangzhuanZP>) : void
      {
         Model_HuangzhuanZP.shengYu = shengYu;
         Model_HuangzhuanZP.award_data = award_data;
         Model_HuangzhuanZP.vecPlayVo = vecPlayVo;
         (Singleton.getInstance(Delegate123) as Delegate123).dosomething(View_HuangzhuanZP.instance,function():void
         {
            View_HuangzhuanZP.instance.visible = true;
            View_HuangzhuanZP.instance.update();
         });
      }
      
      public static function GC_HZZP_CJ(currentIndex:int, shengYu:int) : void
      {
         Model_HuangzhuanZP.currentIndex = currentIndex;
         Model_HuangzhuanZP.shengYu = shengYu;
         View_HuangzhuanZP.instance.updateOpen();
      }
      
      public static function CG_HZZP_ICON(reslut:int) : void
      {
         Icon_Huangzhuan.instance.init(reslut);
      }
   }
}

