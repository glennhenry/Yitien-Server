package com.yiTian.view.modules.treeDownCL
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.mainUIBtnContainer.View_mainUiBtn_container;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Model_treeCL
   {
      
      private static var maskSp:Sprite;
      
      public static var delayRightAnswerKey:int;
      
      public static var pointL:Point = new Point(663,764);
      
      public static var pointR:Point = new Point(1560,773);
      
      public static var ADD_EXPERIANCE:String = "add_experiance";
      
      public static var maskWid:int = 395;
      
      public static var maskHei:int = 280;
      
      public static var watchX:int = 0;
      
      public static var watchY:int = 0;
      
      public static var effIdStr:String = "35062";
      
      public static var anSwerSign:Boolean = false;
      
      public static var delayAnswer:Array = [];
      
      public static var enterTreeActionsType:int = 0;
      
      public static var countSixty:int = 60;
      
      public static var answerBegin:int = 15;
      
      public static var answerEnd:int = 15;
      
      public static var titleId:int = 1;
      
      public static var correctNums:int = 0;
      
      public static var inCorrectNums:int = 0;
      
      public static var currentTitle:int = 1;
      
      public static var totalNums:int = 20;
      
      public static var answerArr:Array = [];
      
      public static var answerKey:int = 1;
      
      public static var _actionIsStart:Boolean = false;
      
      public static var enterTreeSceneSign:Boolean = false;
      
      public function Model_treeCL()
      {
         super();
      }
      
      public static function addMaskUnit() : void
      {
         if(!maskSp)
         {
            maskSp = new Sprite();
            maskSp.graphics.beginFill(0,0);
            maskSp.graphics.drawRect(0,0,maskWid,maskHei);
            maskSp.graphics.endFill();
            GameScene.uiLayer.addChild(maskSp);
            TitlePan.instance.mask = maskSp;
            ComponentUtil.setPropertie(maskSp,{
               "x":(Global.stage.stageWidth - 300) / 2 - 50,
               "y":103
            });
            Global.control.registerCallBack(Enum_MsgType.STAGE_RESIZE,function():void
            {
               ComponentUtil.setPropertie(maskSp,{
                  "x":(Global.stage.stageWidth - 300) / 2 - 50,
                  "y":103
               });
            });
         }
      }
      
      public static function set actionType(value:int) : void
      {
         enterTreeActionsType = value;
      }
      
      public static function get actionType() : int
      {
         return enterTreeActionsType;
      }
      
      public static function enterHandle() : void
      {
         addMaskUnit();
         if(enterTreeActionsType == 1)
         {
            Child_itemCount.instance.update(countSixty);
            Child_infomAnswer.instance.update(correctNums,inCorrectNums,currentTitle,totalNums);
         }
         else if(enterTreeActionsType == 2)
         {
            TitlePan.instance.update(titleId);
            Child_infomAnswer.instance.update(correctNums,inCorrectNums,currentTitle,totalNums);
            Answers.instance.showAnswer(Model_treeCL.answerArr);
         }
         else if(enterTreeActionsType == 3)
         {
            if(TitlePan.instance.visible)
            {
               TitlePan.instance.visible = false;
            }
            Answers.instance.showAnswer(Model_treeCL.answerArr);
            Child_infomAnswer.instance.moveTf(answerEnd);
         }
      }
      
      public static function set isActionBegin(value:Boolean) : void
      {
         _actionIsStart = value;
         if(TreeOutsidePan.instance.visible)
         {
            TreeOutsidePan.instance.update(value ? 2 : 1);
         }
      }
      
      public static function get answerId() : int
      {
         var _x:int = GameUnitManager.hero.global_x;
         var _y:int = GameUnitManager.hero.global_y;
         var disL:int = Utils.dist(pointL.x,pointL.y,_x,_y);
         var disR:int = Utils.dist(pointR.x,pointR.y,_x,_y);
         if(disL < disR)
         {
            return 0;
         }
         return 1;
      }
      
      public static function showAnswerUp() : void
      {
         var correctAnswer:String = Data_lib.DSCLTitle[delayRightAnswerKey][4];
         var corrIndex:int = delayAnswer.indexOf(correctAnswer);
         if(corrIndex == -1)
         {
            return;
         }
         Answers.instance.showAnswer(delayAnswer);
         Answers.instance.rightIndex = corrIndex;
      }
      
      public static function hideAllExcShouChong() : void
      {
         enterTreeSceneSign = true;
         Global.control.registerCallBack(View_mainUiBtn_container.ADD_BTN,addBtnHd);
         UIManager.mainUiBtnContainer.hideAllBtnExc(UIManager.shouChongPanel.SCBtn,UIManager.mainUiBtnContainer.leaveBtn);
         UIManager.questTraceView.visible = false;
         UIManager.newMainBtnContainer.visible = false;
         watchX = 1162;
         watchY = 784;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,jumpScene);
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,jumpScene);
      }
      
      private static function jumpScene() : void
      {
         if(SceneConfig.getSceneType() != SceneConfig.DSCL)
         {
            watchX = 0;
            watchY = 0;
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,jumpScene);
            Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,jumpScene);
         }
      }
      
      public static function showAllExcShouChong() : void
      {
         enterTreeSceneSign = false;
         Global.control.removeCallBack(View_mainUiBtn_container.ADD_BTN,addBtnHd);
         UIManager.mainUiBtnContainer.showAllExc();
         UIManager.questTraceView.visible = true;
         UIManager.newMainBtnContainer.visible = true;
         watchX = 0;
         watchY = 0;
      }
      
      public static function addBtnHd(btn:DisplayObject) : void
      {
         if(btn != UIManager.shouChongPanel.SCBtn && btn != UIManager.mainUiBtnContainer.leaveBtn)
         {
            btn.visible = false;
         }
      }
      
      public static function addExp(exp:int) : void
      {
         ActionEndTipPan.experiences += exp;
      }
      
      public static function toTarget(index:int) : Object
      {
         return Answers.instance.targetPosOf(index);
      }
      
      public static function get pointSomeTf() : Point
      {
         return Child_infomAnswer.instance.getSomeTfPos;
      }
      
      public static function actionsEnd() : void
      {
         Child_itemCount.instance.hide();
         Child_infomAnswer.instance.hide();
         TitlePan.instance.hide();
         actionType = 0;
         anSwerSign = false;
         Answers.instance.removeAnswerItem();
      }
   }
}

