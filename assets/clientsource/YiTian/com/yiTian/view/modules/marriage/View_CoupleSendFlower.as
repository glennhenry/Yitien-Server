package com.yiTian.view.modules.marriage
{
   import com.event.TextField_h;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class View_CoupleSendFlower extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private var bg:DisplayObjectContainer;
      
      private var _data:Object = null;
      
      public var cashGift_idList:Array;
      
      public var cashGift_costList:Array;
      
      public var selectItem:int = 0;
      
      public var itemList:Array = new Array();
      
      private var tf_marriageName:TextField_h;
      
      private var tf_title:MyTextField;
      
      private var tf_tip:TextField_h;
      
      private var titleTf:TextField_h;
      
      private var fl_cost:Array = [1,99,999];
      
      private var fl_costYB:Array = ["3","260","2500"];
      
      private const FLOWER_ITMEID:int = 46439;
      
      private var _tmpType:int;
      
      public function View_CoupleSendFlower()
      {
         this.cashGift_idList = MarriageConfig.cashGift_idList;
         this.cashGift_costList = MarriageConfig.cashGift_costList;
         super();
         this.initB();
      }
      
      private function initB() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         bindParent = GameScene.uiLayer;
         bAutoRemove = false;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":11,
            "y":16,
            "width":248,
            "height":220
         },Global.Img_Cdm);
         Utils.loadTitle("lang/ch/HunLi_Imgs.swf","HunLi_List",new Bitmap(),{
            "x":0,
            "y":0
         },this.bg);
         this.tf_marriageName = ComponentUtil.getTextField_h("",this,{
            "x":this.bg.width / 2,
            "y":17
         });
         this.tf_marriageName.autoSize = TextFormatAlign.CENTER;
         this.tf_title = ComponentUtil.getTextField("",this,{
            "x":22,
            "y":40,
            "realWidth":223,
            "multiline":true
         });
         this.tf_title.wordWrap = true;
         this.getRingGroup();
         this.tf_tip = ComponentUtil.getTextField_h("",this,{
            "x":this.bg.width / 2,
            "y":179,
            "textColor":14013809
         });
         this.tf_tip.autoSize = TextFormatAlign.CENTER;
         this.tf_tip.multiline = true;
         this.tf_tip.visible = false;
         var str:String = LangConfig.getWord("29285",2);
         this.tf_tip.htmlText = str;
         addEventListener(MouseEvent.CLICK,GameScene.instance.uiOnGo);
      }
      
      private function getRingGroup() : void
      {
         var temp:Child_HongBao = null;
         var i:int = 0;
         while(i < 3)
         {
            temp = new Child_HongBao(i);
            addChild(temp);
            temp.x = -10 + i * 76;
            temp.y = 65;
            temp.setVis(false);
            temp.setTf(12);
            temp.btn.addEventListener(MouseEvent.CLICK,UIManager.hongbao.onClick);
            i++;
         }
      }
      
      public function update() : void
      {
         var obj:Object = Model_Marriage.curMarriageInfo;
         if(!obj || Global.sceneID != 12304)
         {
            this.visible = false;
            return;
         }
         if(!visible)
         {
            this.visible = true;
         }
         var type:int = int(obj.marriageType);
         var myID:int = GameUnitManager.hero.id;
         var targetName:String = myID != obj.maleID ? obj.maleName : obj.femaleName;
         var strFil:String = " <font color=\'#00aa00\'>" + targetName + "</font> ";
         var str:String = LangConfig.getWord("29281",2,strFil);
         var marriageNameStrArr:Array = MarriageConfig.marriageNameStrArr;
         this.tf_marriageName.htmlText = Enum_BroadCastTool.instance.getColorStr(marriageNameStrArr[type - 1],type + 1);
         this.tf_title.htmlText = "<font color=\'#FFFF00\'>" + str;
         this.updateLabel();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               if(!Global.HunLi_Imgs)
               {
                  SingleLoader.add("lang/ch/HunLi_Imgs.swf",function(info:Object):void
                  {
                     Global.HunLi_Imgs = info.applicationDomain;
                     showBmp();
                  });
               }
            }
            else
            {
               this.showBmp();
            }
         }
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("HunLi_List",this,{
            "x":0,
            "y":0
         },Global.HunLi_Imgs);
         this.titleTf = ComponentUtil.getTextField_h("",this,{
            "x":108,
            "y":17
         });
         this.updateLabel();
      }
      
      public function updateLabel() : void
      {
         var type:int = 0;
         if(Boolean(this.titleTf) && Boolean(Model_Marriage.curMarriageInfo))
         {
            type = int(Model_Marriage.curMarriageInfo.marriageType);
            this.titleTf.htmlText = Enum_BroadCastTool.instance.getColorStr(MarriageConfig.marriageNameStrArr[type - 1],type + 1);
         }
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 255;
         y = UIManager.questTraceView.y;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         var alert:String = null;
         var info:Object = null;
         var maleId:Number = NaN;
         var femaleId:Number = NaN;
         var myId:Number = NaN;
         var otherID:Number = NaN;
         var type:int = int(evt.target.tabIndex);
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ITEM_ALL);
         var hasFlower:Boolean = false;
         var str:String = this.fl_costYB[type - 1];
         var count:int = 0;
         var i:int = 0;
         while(i < vec.length)
         {
            if(vec[i] != null && vec[i].id == this.FLOWER_ITMEID)
            {
               count += vec[i].count;
               if(count >= this.fl_cost[type - 1])
               {
                  hasFlower = true;
                  break;
               }
            }
            i++;
         }
         if(!hasFlower)
         {
            alert = LangConfig.getWord("29259",2).replace("%ybcost",this.fl_costYB[type - 1]).replace("%num",this.fl_cost[type - 1].toString());
            this._tmpType = type;
            View_Alert.show(alert,View_Alert.OK_CANCAL,this.useYB);
         }
         else
         {
            info = Model_Marriage.curMarriageInfo;
            if(!info)
            {
               this.visible = false;
               return;
            }
            maleId = Number(info.maleID);
            femaleId = Number(info.femaleID);
            myId = GameUnitManager.hero.id;
            otherID = maleId != myId ? maleId : femaleId;
            FriendCGMessage.CG_SEND_FLOWER(otherID,1,type,1);
         }
      }
      
      private function useYB() : void
      {
         var info:Object = null;
         var maleId:Number = NaN;
         var femaleId:Number = NaN;
         var myId:Number = NaN;
         var otherID:Number = NaN;
         if(GameUnitManager.hero.money < 3 && this._tmpType == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else if(GameUnitManager.hero.money < 260 && this._tmpType == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else if(GameUnitManager.hero.money < 2500 && this._tmpType == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else
         {
            info = Model_Marriage.curMarriageInfo;
            if(!info)
            {
               this.visible = false;
               return;
            }
            maleId = Number(info.maleID);
            femaleId = Number(info.femaleID);
            myId = GameUnitManager.hero.id;
            otherID = maleId != myId ? maleId : femaleId;
            FriendCGMessage.CG_SEND_FLOWER(otherID,1,this._tmpType,2);
         }
      }
      
      private function moneyCheck(type:int) : Boolean
      {
         if(GameUnitManager.hero.money < this.cashGift_costList[type - 1])
         {
            return false;
         }
         return true;
      }
      
      private function send(type:int) : void
      {
         if(!Model_Marriage.curMarriageInfo)
         {
            Singleton.getInstance(View_SendMarriageBless2).visible = false;
            return;
         }
         MarriageHandler.CG_MARRIAGE_BLESS_SEND(Model_Marriage.curMarriageInfo.maleID,Model_Marriage.curMarriageInfo.femaleID,type);
      }
   }
}

