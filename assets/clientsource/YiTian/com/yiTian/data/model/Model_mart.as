package com.yiTian.data.model
{
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   
   public class Model_mart
   {
      
      public static var max:int;
      
      public static var martType:int;
      
      public function Model_mart()
      {
         super();
      }
      
      public static function martSoldHandle(str:String) : void
      {
         if(str == LangConfig.getWord("380",0))
         {
            if(!UIManager.sold_set.visible)
            {
               UIManager.sold_set.visible = true;
            }
            if(!UIManager.bagPanel.visible)
            {
               UIManager.bagPanel.visible = true;
               UIManager.bagPanel.x = (Global.stage.stageWidth - 645) / 2 + 720;
            }
            UIManager.sold_set.setTitle(LangConfig.getWord("493",0),1);
            UIManager.sold_set.parent.setChildIndex(UIManager.sold_set,UIManager.sold_set.parent.numChildren - 1);
            UIManager.bagPanel.parent.setChildIndex(UIManager.bagPanel,UIManager.bagPanel.parent.numChildren - 1);
         }
         else if(str == LangConfig.getWord("381",0))
         {
            if(!UIManager.sold_set.visible)
            {
               UIManager.sold_set.visible = true;
            }
            if(!UIManager.bagPanel.visible)
            {
               UIManager.bagPanel.visible = true;
               UIManager.bagPanel.x = (Global.stage.stageWidth - 645) / 2 + 720;
            }
            UIManager.sold_set.setTitle(LangConfig.getWord("494",0),2);
            UIManager.sold_set.parent.setChildIndex(UIManager.sold_set,UIManager.sold_set.parent.numChildren - 1);
            UIManager.bagPanel.parent.setChildIndex(UIManager.bagPanel,UIManager.bagPanel.parent.numChildren - 1);
         }
      }
   }
}

