package com.yiTian.view.modules.marriage
{
   import com.event.TextField_h;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.net.message.cg.MarriageCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   
   public class View_SendMarriageBless2 extends Panel
   {
      
      private var bg:DisplayObjectContainer;
      
      private var _data:Object = null;
      
      public var cashGift_idList:Array;
      
      public var cashGift_costList:Array;
      
      public var selectItem:int = 0;
      
      public var itemList:Array = new Array();
      
      private var tf_marriageName:TextField_h;
      
      private var tf_title:MyTextField;
      
      private var tf_tip:TextField_h;
      
      private var btnArr:Array = new Array();
      
      private var _tmpType:int;
      
      public function View_SendMarriageBless2()
      {
         this.cashGift_idList = MarriageConfig.cashGift_idList;
         this.cashGift_costList = MarriageConfig.cashGift_costList;
         super();
         this.initB();
      }
      
      private function initB() : void
      {
         bindParent = GameScene.uiLayer;
         bAutoRemove = false;
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back_Translucent",[2,2,4,4],this.bg,{
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
            "x":35,
            "y":40,
            "realWidth":195
         });
         this.tf_title.autoSize = TextFieldAutoSize.CENTER;
         this.tf_title.wordWrap = true;
         this.tf_title.mouseEnabled = true;
         this.tf_title.addEventListener(TextEvent.LINK,this.link);
         this.getRingGroup();
         this.tf_tip = ComponentUtil.getTextField_h("",this,{
            "x":this.bg.width / 2,
            "y":179,
            "textColor":14013809
         });
         this.tf_tip.autoSize = TextFormatAlign.CENTER;
         this.tf_tip.multiline = true;
         this.tf_tip.htmlText = LangConfig.getWord("29283",2);
         addEventListener(MouseEvent.CLICK,GameScene.instance.uiOnGo);
      }
      
      private function link(e:TextEvent) : void
      {
         GameScene.instance.onTextEventLink();
         var prom:MarriagePromt = Singleton.getInstance(MarriagePromt) as MarriagePromt;
         prom.show(this.remind);
      }
      
      private function remind() : void
      {
         if(GameUnitManager.hero.money < 8)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29",0));
            return;
         }
         MarriageCGMessage.CG_MARRIAGE_ADD();
      }
      
      private function getRingGroup() : void
      {
         var expArr:Array = null;
         var i:int = 0;
         var tempGrid:View_Grid = null;
         var vo:Vo_item = null;
         var btn:Button = null;
         var str:String = null;
         expArr = [20000,50000,100000];
         i = 0;
         while(i < 3)
         {
            tempGrid = new View_Grid(true);
            tempGrid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
            tempGrid.set_bmp_over(true,null);
            vo = new Vo_item();
            vo.id = this.cashGift_idList[i];
            vo.Init_lib();
            tempGrid.vo = vo;
            this.addChild(tempGrid);
            tempGrid.x = 20 + i * 80;
            tempGrid.y = 76;
            this.itemList.push(tempGrid);
            btn = ComponentUtil.getButton(LangConfig.getWord("29279",2),"Button_Orange",this,{
               "x":tempGrid.x - 2,
               "y":155
            },Global.Img_Cdm);
            btn.tabIndex = i + 1;
            btn.callBack = this.onClick;
            this.btnArr.push(btn);
            str = LangConfig.getWord("29275",2,expArr[i].toString());
            TipManager.bind(btn,str);
            btn.name = (i + 1).toString();
            i++;
         }
      }
      
      public function update() : void
      {
         var obj:Object = Model_Marriage.curMarriageInfo;
         if(!obj || Global.sceneID != 12304)
         {
            visible = false;
            return;
         }
         if(!visible)
         {
            visible = true;
         }
         var type:int = int(obj.marriageType);
         var str:String = MarriageConfig.marriageNameStrArr[type - 1];
         this.tf_marriageName.htmlText = Enum_BroadCastTool.instance.getColorStr(str,type + 1);
         var str2:String = LangConfig.getWord("1042",0,obj.maleName,obj.femaleName);
         str2 = HtmlUtil.unSize(str2);
         this.tf_title.htmlText = str2;
         this.updataGridPos();
      }
      
      private function updataGridPos() : void
      {
         var itemG:View_Grid = null;
         var gg:View_Grid = null;
         var itemBtn:Button = null;
         var bb:Button = null;
         for each(itemG in this.itemList)
         {
            itemG.y = this.tf_title.y + this.tf_title.textHeight + 8;
         }
         gg = this.itemList[0];
         for each(itemBtn in this.btnArr)
         {
            itemBtn.y = gg.y + gg.height + 3;
         }
         bb = this.btnArr[0];
         this.tf_tip.y = bb.y + bb.height + 3;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - this.bg.width;
         y = UIManager.questTraceView.y;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         if(!Model_Marriage.curMarriageInfo)
         {
            visible = false;
         }
         var type:int = (evt.target as Button).tabIndex;
         this._tmpType = type;
         var color:String = Model_Marriage.getColorStrByVoColor(this.itemList[type - 1].vo.color);
         var item:String = HtmlUtil.font(this.itemList[type - 1].vo.str_name,color);
         var str:String = LangConfig.getWord("29282",2,this.cashGift_costList[type - 1].toString(),Model_Marriage.curMarriageInfo.maleName,Model_Marriage.curMarriageInfo.femaleName,item);
         if(this.moneyCheck(type))
         {
            View_Alert.show(str,View_Alert.OK_CANCAL,this.alertFun);
         }
         else
         {
            Model_Marriage.showAlert(106);
         }
      }
      
      private function alertFun() : void
      {
         if(!Model_Marriage.curMarriageInfo)
         {
            return;
         }
         if(this.moneyCheck(this._tmpType))
         {
            this.send(this._tmpType);
         }
         else
         {
            Model_Marriage.showAlert(106);
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

