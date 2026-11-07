package com.yiTian.data.model
{
   import com.yiTian.data.vo.Vo_YellowDia_ND_Play;
   import com.yiTian.data.vo.Vo_Yellow_Goods;
   
   public class Model_Yellow_Dia_ND
   {
      
      public static var vecPlayVo:Vector.<Vo_YellowDia_ND_Play> = new Vector.<Vo_YellowDia_ND_Play>();
      
      public static var panelObj:Object = {
         "paiXuHao":0,
         "curYuanBao":0,
         "maxYuanBao":0,
         "shengYu":0,
         "isOver":""
      };
      
      public static var vecGoods:Vector.<Vo_Yellow_Goods> = new Vector.<Vo_Yellow_Goods>();
      
      public function Model_Yellow_Dia_ND()
      {
         super();
      }
   }
}

