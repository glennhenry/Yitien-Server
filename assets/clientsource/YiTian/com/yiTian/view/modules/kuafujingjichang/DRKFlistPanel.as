package com.yiTian.view.modules.kuafujingjichang
{
   import Layout.GridGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_KuaFuJingJiChang;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.StrFilter;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.playerExtend.View_PlayerExtendPanel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flashx.textLayout.formats.TextAlign;
   
   public class DRKFlistPanel extends Panel123
   {
      
      private static var _instance:DRKFlistPanel;
      
      private var back:ScaleBitmap;
      
      public var roomname:MyTextField;
      
      private var level:MyTextField;
      
      private var password:MyTextField;
      
      private var ChuangJianBtn:Button;
      
      private var page:MyTextField;
      
      private var joinBtn:Button;
      
      private var seachBtn:Button;
      
      private var lastPage:Button;
      
      private var nextPage:Button;
      
      private var room:Bitmap;
      
      private var nowPage:int = 1;
      
      private var pageMax:int;
      
      private var index:int;
      
      private var list:DRKFChild_List;
      
      private var type:int = -1;
      
      private var questBtn:Button;
      
      private var _itemsLay:GridGroup;
      
      private var _items:Array = [];
      
      private var voArr:Array = [44477,44529,44631];
      
      public function DRKFlistPanel()
      {
         super();
         regResource("lang/ch/DRKF_Imgs.swf","DRKF_Imgsdm");
         init();
      }
      
      public static function get instance() : DRKFlistPanel
      {
         if(!_instance)
         {
            _instance = new DRKFlistPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         bindParent = GameScene.modalLayer;
         this.back = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":886,
            "height":534
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Img",[26,26,2,2],this,{
            "x":24,
            "y":40,
            "width":838,
            "height":485
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_TeamInf",this,{
            "x":598,
            "y":50
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Img_TeamInf",this,{
            "x":607,
            "y":59
         },Global.DRKF_Imgsdm);
         this.questBtn = ComponentUtil.getButton("","Button_Inf",this,{
            "x":786,
            "y":66,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         i = 0;
         while(i < 3)
         {
            ComponentUtil.getBitmap("Grid_Open",this,{
               "x":630 + i * 50,
               "y":257
            },Global.Img_Cdm);
            grid = new View_Grid();
            grid.type = Enum_type_grid.NO_DRAG;
            grid.set_tf_count(true);
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            addChild(grid);
            grid.x = 630 + i * 50 + 2;
            grid.y = 257 + 2;
            vo = new Vo_item();
            vo.id = this.voArr[i];
            vo.Init_lib();
            grid.vo = vo;
            i++;
         }
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":40,
            "y":97
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":408,
            "y":97
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":224,
            "y":97
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":224,
            "y":289
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":408,
            "y":289
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_Room",this,{
            "x":40,
            "y":289
         },Global.DRKF_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Green_01",[3,3,1,1],this,{
            "x":35,
            "y":92,
            "width":557,
            "height":422
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_DRKFJingJi",this,{
            "x":363,
            "y":5
         },Global.DRKF_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":691,
            "y":349,
            "width":136,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":691,
            "y":375,
            "width":136,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":691,
            "y":401,
            "width":136,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":280,
            "y":483,
            "width":68,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getTextField("房间名称：",this,{
            "x":627,
            "y":349,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("等级区域：",this,{
            "x":627,
            "y":375,
            "color":11523767,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("密码设置：",this,{
            "x":627,
            "y":401,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.roomname = ComponentUtil.getTextField("称霸武林",this,{
            "x":697,
            "y":349,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.roomname.type = TextFieldType.INPUT;
         this.roomname.maxChars = 6;
         this.level = ComponentUtil.getTextField("000-000",this,{
            "x":697,
            "y":375,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.password = ComponentUtil.getTextField("输入数字可设置密码",this,{
            "x":697,
            "y":401,
            "color":13424242,
            "size":12,
            "leading":0,
            "realWidth":128,
            "realHeight":19
         });
         this.password.type = TextFieldType.INPUT;
         this.password.maxChars = 6;
         this.password.restrict = "0-9";
         this.lastPage = ComponentUtil.getButton("上一页","Button_Four",this,{
            "x":202,
            "y":483,
            "textColor":16184781
         },Global.Img_Cdm);
         this.nextPage = ComponentUtil.getButton("下一页","Button_Four",this,{
            "x":353,
            "y":483,
            "textColor":16184781
         },Global.Img_Cdm);
         this.lastPage.addEventListener(MouseEvent.CLICK,this.lastClick);
         this.nextPage.addEventListener(MouseEvent.CLICK,this.nextClick);
         move = new Rectangle(0,0,this.back.width,35);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":852,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.addEventListener(MouseEvent.CLICK,this.closeClick);
         this.password.addEventListener(MouseEvent.CLICK,this.passwordClick);
         this.joinBtn = ComponentUtil.getButton("","Button_QuickJoin",this,{
            "x":623,
            "y":445,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.page = ComponentUtil.getTextField("00/00",this,{
            "x":295,
            "y":485,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.page.align = TextAlign.CENTER;
         this.seachBtn = ComponentUtil.getButton("","Button_Seach",this,{
            "x":701,
            "y":445,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.ChuangJianBtn = ComponentUtil.getButton("","Button_Create",this,{
            "x":775,
            "y":439,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.joinBtn.addEventListener(MouseEvent.CLICK,this.joinClick);
         this.seachBtn.addEventListener(MouseEvent.CLICK,this.seachClick);
         this.ChuangJianBtn.addEventListener(MouseEvent.CLICK,this.chuangJianClick);
         TipManager.bind(this.questBtn,LangConfig.getWord("60499",6));
      }
      
      public function show(source:Array) : void
      {
         var it:DRKFItem = null;
         this._itemsLay = new GridGroup(42,100,0,0,0,180,0,180,3);
         if(!source)
         {
            source = [];
         }
         while(Boolean(this._items.length))
         {
            removeChild(this._items[0]);
            this._items.shift();
         }
         var i:int = 0;
         while(i < source.length)
         {
            it = new DRKFItem();
            it.show(source[i]);
            this._items.push(it);
            this._itemsLay.appendItem(it);
            addChild(it);
            i++;
         }
         this._itemsLay.align();
         if(ModalUIManager.isShow)
         {
            return;
         }
         ModalUIManager.POPUP(this,"center",false);
      }
      
      public function shuaxin() : void
      {
         if(this.nowPage > this.pageMax)
         {
            this.nowPage = this.pageMax;
         }
         this.page.text = this.nowPage + "/" + this.pageMax;
         DRKFlistPanel.instance.show(Model_KuaFuJingJiChang.teamlist[this.nowPage - 1]);
      }
      
      private function lastClick(e:MouseEvent) : void
      {
         if(this.nowPage > 1)
         {
            --this.nowPage;
         }
         this.page.text = this.nowPage + "/" + this.pageMax;
         DRKFlistPanel.instance.show(Model_KuaFuJingJiChang.teamlist[this.nowPage - 1]);
      }
      
      private function nextClick(e:MouseEvent) : void
      {
         if(this.nowPage < this.pageMax)
         {
            ++this.nowPage;
         }
         this.page.text = this.nowPage + "/" + this.pageMax;
         DRKFlistPanel.instance.show(Model_KuaFuJingJiChang.teamlist[this.nowPage - 1]);
      }
      
      public function update() : void
      {
         if(!this.room)
         {
            this.room = ComponentUtil.getBitmap("Text_DaXia",this,{
               "x":42,
               "y":45
            },Global.DRKF_Imgsdm);
         }
         this.room.bitmapData = null;
         if(GameUnitManager.hero.level >= 40 && GameUnitManager.hero.level <= 59)
         {
            this.room.bitmapData = ComponentUtil.getBitmapData("Text_QunXiong",Global.DRKF_Imgsdm);
         }
         else if(GameUnitManager.hero.level >= 60 && GameUnitManager.hero.level <= 79)
         {
            this.room.bitmapData = ComponentUtil.getBitmapData("Text_DaXia",Global.DRKF_Imgsdm);
         }
         else if(GameUnitManager.hero.level >= 80 && GameUnitManager.hero.level <= 99)
         {
            this.room.bitmapData = ComponentUtil.getBitmapData("Text_ZongShi",Global.DRKF_Imgsdm);
         }
         else if(GameUnitManager.hero.level >= 100 && GameUnitManager.hero.level <= 119)
         {
            this.room.bitmapData = ComponentUtil.getBitmapData("Text_DiYu",Global.DRKF_Imgsdm);
         }
         else if(GameUnitManager.hero.level >= 120 && GameUnitManager.hero.level <= 139)
         {
            this.room.bitmapData = ComponentUtil.getBitmapData("Text_MoShen",Global.DRKF_Imgsdm);
         }
         this.level.text = (int(GameUnitManager.hero.level / 10) * 10).toString() + "级至" + int(GameUnitManager.hero.level / 10).toString() + "9级";
         this.pageMax = int((Model_KuaFuJingJiChang.listVo.length - 1) / 8) + 1;
         this.page.text = this.nowPage + "/" + this.pageMax;
         this.shuaxin();
      }
      
      public function hide() : void
      {
         ModalUIManager.UNPOP();
      }
      
      private function passwordClick(e:MouseEvent) : void
      {
         if(this.password.text == "输入数字可设置密码")
         {
            this.password.text = "";
         }
      }
      
      public function closeClick(e:MouseEvent = null) : void
      {
         this.hide();
         KuaFuJingJiChangCGMessage.CG_CLOSE_DRKFLIST();
      }
      
      private function joinClick(e:MouseEvent) : void
      {
         KuaFuJingJiChangCGMessage.CG_KUAFUADD_QUICK();
      }
      
      private function seachClick(e:MouseEvent) : void
      {
         Global.delegate.dosomething(SeachPanel.instance,function():void
         {
            SeachPanel.instance.show();
         });
      }
      
      private function chuangJianClick(e:MouseEvent) : void
      {
         var str:String = null;
         if(this.password.text == "输入数字可设置密码")
         {
            this.password.text = "";
         }
         str = this.roomname.text;
         StrFilter.load(str,function():void
         {
            if(StrFilter.hasUnRegisterString(str) == false)
            {
               KuaFuJingJiChangCGMessage.CG_KUAFUTEAM_NEW(GameUnitManager.hero.level / 10 - 3,str,password.text);
            }
            else
            {
               UIManager.centerBroadcast.addMsg("房间名称不合法");
            }
         });
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.back.width) / 2;
         y = (Global.stage.stageHeight - this.back.height) / 2;
      }
      
      private function onAskSceneOk() : void
      {
         KuaFuJingJiChangCGMessage.CG_LEAVE_DRKFTEAM(2);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_FUBEN,arguments.callee);
         Global.control.removeCallBack(Enum_MsgType.MSG_ENTER_SCENE,arguments.callee);
         this.closeClick();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.password.text = "输入数字可设置密码";
            if(TeamPanel.instance.visible == false)
            {
               View_PlayerExtendPanel.instance.getItem(true);
            }
         }
         else
         {
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_FUBEN,this.onAskSceneOk);
            Global.control.registerCallBack(Enum_MsgType.MSG_ENTER_SCENE,this.onAskSceneOk);
         }
      }
   }
}

