package com.yiTian.manager
{
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.scene.GameScene;
   import com.yiTian.view.UIBase;
   import com.yiTian.view.modules.FeiXingQi.View_FXQGuessing;
   import com.yiTian.view.modules.FeiXingQi.View_FXQReward;
   import com.yiTian.view.modules.FeiXingQi.View_Prompt;
   import com.yiTian.view.modules.tianTi.View_ZMRCleanUp;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.utils.describeType;
   
   public class ModalUIManager
   {
      
      private static var curLayout:String;
      
      private static var modelShape:Shape;
      
      public static var fxqReward:View_FXQReward = new View_FXQReward();
      
      public static var fxqGuessingPanel:View_FXQGuessing = new View_FXQGuessing();
      
      public static var fxqPromty:View_Prompt = new View_Prompt();
      
      public static var ZMRCleanUp:View_ZMRCleanUp = new View_ZMRCleanUp();
      
      private static var _viewers:Array = [];
      
      public function ModalUIManager()
      {
         super();
      }
      
      public static function get isShow() : Boolean
      {
         return _viewers.length != 0;
      }
      
      public static function POPUP(target:UIBase, layout:String = "center", single:Boolean = true) : void
      {
         var topUibase:UIBase = _viewers.pop();
         if(single && Boolean(topUibase))
         {
            if(Boolean(topUibase))
            {
               topUibase.visible = false;
            }
         }
         if(_viewers.indexOf(target) == -1)
         {
            _viewers.push(target);
         }
         curLayout = layout;
         modelShape.visible = true;
         target.visible = true;
         KeyboardManager.isEnabled = false;
         resetPos();
         Global.control.sendNotification(Enum_MsgType.MODAL_SHOW,null);
      }
      
      public static function HIDE(hideModal:Boolean = false) : void
      {
         var uibase:UIBase = null;
         for each(uibase in _viewers)
         {
            uibase.visible = false;
         }
         _viewers.splice(0);
         if(hideModal.valueOf())
         {
            modelShape.visible = false;
         }
         Global.control.sendNotification(Enum_MsgType.MODAL_HIDE,null);
      }
      
      public static function UNPOP() : void
      {
         var uibase:UIBase = _viewers.pop();
         if(Boolean(uibase))
         {
            uibase.visible = false;
         }
         if(_viewers.length == 0)
         {
            KeyboardManager.isEnabled = true;
            modelShape.visible = false;
            Global.control.sendNotification(Enum_MsgType.MODAL_HIDE,null);
         }
      }
      
      public static function getCurViewer() : DisplayObject
      {
         return _viewers[_viewers.length - 1];
      }
      
      public static function init() : void
      {
         var propertyInfo:XML = null;
         var propertyName:String = null;
         modelShape = new Shape();
         GameScene.modalLayer.addChild(modelShape);
         var properties:XMLList = describeType(ModalUIManager).variable;
         for each(propertyInfo in properties)
         {
            propertyName = propertyInfo.@name;
            if(ModalUIManager[propertyName])
            {
               if(ModalUIManager[propertyName] is UIBase)
               {
                  (ModalUIManager[propertyName] as UIBase).init();
               }
            }
         }
      }
      
      private static function algin() : void
      {
         switch(curLayout)
         {
            case "center":
               _viewers[_viewers.length - 1].x = (Global.stage.stageWidth - _viewers[_viewers.length - 1].width) / 2;
               _viewers[_viewers.length - 1].y = (Global.stage.stageHeight - _viewers[_viewers.length - 1].height) / 2;
               break;
            case "right300":
               _viewers[_viewers.length - 1].x = (Global.stage.stageWidth - _viewers[_viewers.length - 1].width) / 2 + 300;
               _viewers[_viewers.length - 1].y = (Global.stage.stageHeight - _viewers[_viewers.length - 1].height) / 2;
         }
      }
      
      public static function resetPos() : void
      {
         if(!_viewers.length)
         {
            modelShape.visible = false;
            return;
         }
         drawShape();
         modelShape.visible = true;
         algin();
      }
      
      private static function drawShape() : void
      {
         modelShape.graphics.clear();
         modelShape.graphics.beginFill(0,0.3);
         modelShape.graphics.drawRect(0,0,Global.stage.stageWidth,Global.stage.stageHeight);
         modelShape.graphics.endFill();
      }
   }
}

