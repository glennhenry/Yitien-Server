package com.yiTian.data.model
{
   import com.ui.controls.CheckBox;
   import com.yiTian.data.vo.Vo_ZhaoCaiMao;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ZhaoCaiMaoCGMessage;
   import com.yiTian.view.comp.View_Alert;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Model_ZhaoCaiMao
   {
      
      private static var _instance:Model_ZhaoCaiMao;
      
      public var currentZM:int;
      
      public var currentSY:int;
      
      public var currentPage:int = 1;
      
      public var maxPage:int;
      
      public var myIndex:String;
      
      public var activityStatus:Dictionary = new Dictionary();
      
      public var data:Vector.<Vo_ZhaoCaiMao> = new Vector.<Vo_ZhaoCaiMao>();
      
      private var isShowCheckBox:Boolean;
      
      private var flag:int;
      
      public function Model_ZhaoCaiMao()
      {
         super();
      }
      
      public static function get instance() : Model_ZhaoCaiMao
      {
         if(!_instance)
         {
            _instance = new Model_ZhaoCaiMao();
         }
         return _instance;
      }
      
      public function ZM() : void
      {
         var silver:int = 0;
         if(this.flag == 0)
         {
            this.flag = setTimeout(function():void
            {
               clearTimeout(flag);
               flag = 0;
            },3000);
            if(this.currentZM <= 4 || this.isShowCheckBox)
            {
               ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_ZHAOMU();
            }
            else
            {
               silver = GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver;
               if(silver >= 20000)
               {
                  View_Alert.show("是否花费20000银子招募饲养(每天免费5次)",View_Alert.OK_CANCAL,function():void
                  {
                     ZhaoCaiMaoCGMessage.CG_ZHAOCAIMAO_ZHAOMU();
                  });
                  View_Alert.instance.showCheckBox = function(e:CheckBox):void
                  {
                     isShowCheckBox = e.selected;
                  };
               }
               else
               {
                  UIManager.centerBroadcast.addMsg("银两不足！");
               }
            }
            return;
         }
         UIManager.centerBroadcast.addMsg("操作太频繁！");
      }
   }
}

