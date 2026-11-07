package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.ComboBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.friends.Model_Friends;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_seek_help extends Panel
   {
      
      private var friendText:MyTextField;
      
      private var seekHelpMessage:MyTextField;
      
      private var friendList:ComboBox;
      
      private var onLineArr:Array = [];
      
      private var sendBtn:Button;
      
      private var cancelBtn:Button;
      
      private var masterId:Number = 0;
      
      private var masterName:String;
      
      private var seekId:Number = 0;
      
      private var isLoad:Boolean = false;
      
      public function View_seek_help()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":366,
            "height":178
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":318,
            "height":90
         },Global.Img_Cdm);
         move = new Rectangle(0,0,308,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":332,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("157",9),this,{
            "x":51,
            "y":55,
            "color":16764206,
            "size":14,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("158",9),this,{
            "x":38,
            "y":88,
            "color":16764206,
            "size":14,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":100,
            "y":54,
            "width":113,
            "height":23
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":100,
            "y":87,
            "width":228,
            "height":23
         },Global.Img_Cdm);
         this.friendText = ComponentUtil.getTextField(LangConfig.getWord("156",9),this,{
            "x":119,
            "y":56,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.friendList = new ComboBox([],this.comboxSelectedHd,100,"Button_PageDown","ComboBox_background","xuanze_down",200);
         ComponentUtil.setPropertie(this.friendList,{
            "x":222,
            "y":57
         });
         addChild(this.friendList);
         this.seekHelpMessage = ComponentUtil.getTextField("",this,{
            "x":105,
            "y":89,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.sendBtn = ComponentUtil.getButton(LangConfig.getWord("159",9),"Button_Two64",this,{
            "x":85,
            "y":142,
            "textColor":16184781
         },Global.Img_Cdm);
         this.cancelBtn = ComponentUtil.getButton(LangConfig.getWord("160",9),"Button_Two64",this,{
            "x":217,
            "y":141,
            "textColor":16184781
         },Global.Img_Cdm);
         this.sendBtn.addEventListener(MouseEvent.CLICK,this.sendClickHandle);
         this.cancelBtn.addEventListener(MouseEvent.CLICK,this.canceClickHandle);
      }
      
      private function sendClickHandle(evt:MouseEvent) : void
      {
         if(!this.seekId)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("156",9));
            return;
         }
         FarmCGMessage.cg_farm_seekHelp(GameUnitManager.hero.id,this.seekId,this.masterId,this.seekHelpMessage.text,1);
         this.visible = false;
      }
      
      private function canceClickHandle(evt:MouseEvent) : void
      {
         this.visible = false;
      }
      
      private function comboxSelectedHd(value:Object) : void
      {
         this.seekId = Number(value);
         var i:int = 0;
         while(i < Model_Friends.friendArr.length)
         {
            if(Model_Friends.friendArr[i].id == value)
            {
               this.friendText.text = Model_Friends.friendArr[i].name;
            }
            i++;
         }
      }
      
      public function updateMaster(enemy_id:Number, enemy_name:String) : void
      {
         this.masterId = enemy_id;
         this.masterName = enemy_name;
         this.masterName = Model_heFu.repNameByHero(this.masterName);
         this.seekHelpMessage.htmlText = LangConfig.getWord("154",9,this.masterName);
         this.onLineArr.unshift([LangConfig.getWord("155",9),0]);
         var i:int = 0;
         while(i < Model_Friends.friendArr.length)
         {
            if(Model_Friends.friendArr[i].isOnline == true && Model_Friends.friendArr[i].id != this.masterId && Model_Friends.friendArr[i].level >= 30)
            {
               this.onLineArr.push([Model_Friends.friendArr[i].name,Model_Friends.friendArr[i].id]);
            }
            i++;
         }
         this.friendList.source = this.onLineArr;
         this.friendList.select(0);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         this.onLineArr = [];
         this.friendText.text = LangConfig.getWord("156",9);
         this.seekId = 0;
         if(value)
         {
            if(!this.isLoad)
            {
               this.showTl();
               this.isLoad = true;
            }
         }
      }
      
      private function showTl() : void
      {
         ComponentUtil.getBitmap("BT_QZuHan",this,{
            "x":103,
            "y":5
         },Global.ShanZhuang_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.width) / 2;
         y = (Global.stage.stageHeight - this.height) / 2;
      }
   }
}

