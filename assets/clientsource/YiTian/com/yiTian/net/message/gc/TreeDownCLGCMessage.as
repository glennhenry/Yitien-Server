package com.yiTian.net.message.gc
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.MessageType;
   import com.yiTian.net.message.cg.TreeDownCLCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.treeDownCL.ActionEndTipPan;
   import com.yiTian.view.modules.treeDownCL.Model_treeCL;
   import com.yiTian.view.modules.treeDownCL.TreeIcon;
   import flash.display.Bitmap;
   import flash.utils.IDataInput;
   import flash.utils.setTimeout;
   
   public class TreeDownCLGCMessage
   {
      
      public static var lastAnswerRecord:int;
      
      private var bmp:Bitmap;
      
      private var strArr:Array = ["很抱歉，您答错了！经验+","恭喜你，回答正确，经验+"];
      
      private var urlArr:Array = ["fail","success"];
      
      public function TreeDownCLGCMessage(index:Array)
      {
         super();
         index[MessageType.GC_TREE_ICON_CTRL] = this.GC_TREE_ICON_CTRL;
         index[MessageType.GC_ENTER_TREEMAP_COUNTBACK] = this.GC_ENTER_TREEMAP_COUNTBACK;
         index[MessageType.GC_ENTER_TREEMAP_TITLESHOW] = this.GC_ENTER_TREEMAP_TITLESHOW;
         index[MessageType.GC_SENDANSWER_TREECL] = this.GC_SENDANSWER_TREECL;
      }
      
      private function GC_TREE_ICON_CTRL(patch:IDataInput) : void
      {
         var result:int = patch.readByte();
         if(result == 0)
         {
            TreeIcon.hide();
            Model_treeCL.isActionBegin = false;
         }
         else if(result == 1)
         {
            TreeIcon.hide();
            Model_treeCL.isActionBegin = false;
            Model_treeCL.actionsEnd();
         }
         else if(result == 2)
         {
            TreeIcon.show(true);
            Model_treeCL.isActionBegin = true;
         }
      }
      
      private function GC_ENTER_TREEMAP_COUNTBACK(patch:IDataInput) : void
      {
         if(Model_treeCL.anSwerSign)
         {
            Model_treeCL.anSwerSign = false;
            TreeDownCLCGMessage.CG_SENDANSWER_TREECL(Model_treeCL.answerKey,Model_treeCL.answerArr[Model_treeCL.answerId]);
         }
         var actionType:int = patch.readByte();
         var count:int = patch.readByte();
         Model_treeCL.actionType = actionType;
         this.setValue(actionType,count);
      }
      
      private function setValue(actionType:int, count:int) : void
      {
         if(actionType == 1)
         {
            Model_treeCL.countSixty = count;
            Model_treeCL.enterHandle();
         }
         else if(actionType == 2)
         {
            Model_treeCL.answerBegin = count;
         }
         else if(actionType == 3)
         {
            Model_treeCL.answerEnd = count;
         }
         else if(actionType == 4)
         {
            UIManager.centerBroadcast.addMsg("所有题目都已答完");
            Model_treeCL.actionsEnd();
            ActionEndTipPan.instance.show();
         }
      }
      
      private function GC_ENTER_TREEMAP_TITLESHOW(patch:IDataInput) : void
      {
         var corrects:int = 0;
         var inCorrectNums:int = 0;
         var key:int = 0;
         var ans1:String = null;
         var id:int = patch.readByte();
         corrects = patch.readByte();
         inCorrectNums = patch.readByte();
         key = patch.readShort();
         ans1 = patch.readUTF();
         var ans2:String = patch.readUTF();
         Model_treeCL.currentTitle = Model_treeCL.titleId = id;
         Model_treeCL.correctNums = corrects;
         Model_treeCL.inCorrectNums = inCorrectNums;
         Model_treeCL.answerKey = key;
         Model_treeCL.answerArr = [ans1,ans2];
         if(SceneConfig.getSceneType() != SceneConfig.DSCL)
         {
            return;
         }
         Model_treeCL.enterHandle();
      }
      
      private function GC_SENDANSWER_TREECL(patch:IDataInput) : void
      {
         var startX:int = 0;
         var startY:int = 0;
         var fEff:Effect = null;
         var result:int = patch.readByte();
         lastAnswerRecord = result;
         var addExperiance:int = patch.readInt();
         UIManager.selfBroadcast.addMsg(this.strArr[result] + addExperiance);
         if(!this.bmp)
         {
            this.bmp = new Bitmap();
            GameScene.popupLayer.addChild(this.bmp);
         }
         ComponentUtil.setPropertie(this.bmp,{
            "x":(Global.stage.stageWidth - 150) / 2,
            "y":(Global.stage.stageHeight - 48) / 2
         });
         Utils.getLoadBitmap("resource/image/treeDownCL/" + this.urlArr[result] + ".png",this.bmp,null,function():void
         {
            var n:int = int(setTimeout(function():void
            {
               Tween.to(bmp,1500,{
                  "y":[bmp.y,bmp.y - 100],
                  "alpha":[1,0]
               },function():void
               {
                  GameScene.popupLayer.removeChild(bmp);
                  bmp = null;
               });
            },2500));
         });
         if(result == 1)
         {
            startX = Model_treeCL.pointSomeTf.x + 8;
            startY = Model_treeCL.pointSomeTf.y + 10;
            fEff = EffectManager.addEffect(Model_treeCL.effIdStr,GameScene.popupLayer,300,startX,startY,false,3,function():void
            {
               var eff:* = undefined;
               var i:* = 0;
               while(i < 2)
               {
                  eff = EffectManager.addEffect(Model_treeCL.effIdStr,GameScene.popupLayer,1600,startX,startY);
                  eff.alpha = 0.8;
                  Tween.curTo(eff,800,Model_treeCL.toTarget(i));
                  i++;
               }
            });
            fEff.alpha = 0.8;
         }
         else
         {
            EffectManager.addEffect("35066",GameScene.popupLayer,1500,Model_treeCL.pointSomeTf.x,Model_treeCL.pointSomeTf.y + 100);
         }
         Model_treeCL.showAnswerUp();
      }
   }
}

