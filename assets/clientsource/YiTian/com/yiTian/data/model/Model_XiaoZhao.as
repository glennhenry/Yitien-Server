package com.yiTian.data.model
{
   import com.yiTian.data.config.Enum_XiaoZhao;
   import com.yiTian.view.modules.xiaozhao.XiaoZhao_CardVO;
   import com.yiTian.view.modules.xiaozhao.XiaoZhao_PropVO;
   
   public class Model_XiaoZhao
   {
      
      public static var show_Awards:Array;
      
      public static var curIndex:int;
      
      public static var questArr:Array = [];
      
      public static var STATE_XIPAI:int = 0;
      
      public function Model_XiaoZhao()
      {
         super();
      }
      
      public static function setCardStateData(id:int) : void
      {
         var i:int = 0;
         var isManager:Function = null;
         isManager = function(element:*, index:int, arr:Array):Boolean
         {
            if(element.cardIndex == id + 1)
            {
               i = index;
            }
            return element.propIndex == id;
         };
         var managers:Array = questArr.filter(isManager);
         questArr[i].state = Enum_XiaoZhao.STATE_GET;
      }
      
      public static function getStateById(id:int) : int
      {
         var isManager:Function = null;
         isManager = function(element:*, index:int, arr:Array):Boolean
         {
            return element.propIndex == id;
         };
         var managers:Array = questArr.filter(isManager);
         if(Boolean(managers.length))
         {
            return managers[0].state;
         }
         return Enum_XiaoZhao.STATE_NGET;
      }
      
      public static function getWardById(id:int) : XiaoZhao_PropVO
      {
         var i:int = 0;
         var isManager:Function = null;
         isManager = function(element:*, index:int, arr:Array):Boolean
         {
            if(element.propIndex == id)
            {
               i = index;
            }
            return element.propIndex == id;
         };
         var managers:Array = show_Awards.filter(isManager);
         var v:* = show_Awards[i];
         return show_Awards[i] as XiaoZhao_PropVO;
      }
      
      public static function getOpenCount() : int
      {
         var time:int = 0;
         var i:int = questArr.length - 1;
         while(i >= 0)
         {
            if((questArr[i] as XiaoZhao_CardVO).state == Enum_XiaoZhao.STATE_GET)
            {
               time++;
            }
            i--;
         }
         return time;
      }
      
      public static function isNewer() : Boolean
      {
         var i:XiaoZhao_CardVO = null;
         var isNew:Boolean = true;
         for each(i in questArr)
         {
            if(i.state == Enum_XiaoZhao.STATE_GET)
            {
               isNew = false;
            }
         }
         return isNew;
      }
      
      public static function isEnd() : Boolean
      {
         var i:XiaoZhao_CardVO = null;
         if(STATE_XIPAI != Enum_XiaoZhao.STATE_NXP)
         {
            return false;
         }
         var ed:Boolean = true;
         for each(i in questArr)
         {
            if(i.state == Enum_XiaoZhao.STATE_NGET)
            {
               ed = false;
            }
         }
         return ed;
      }
   }
}

