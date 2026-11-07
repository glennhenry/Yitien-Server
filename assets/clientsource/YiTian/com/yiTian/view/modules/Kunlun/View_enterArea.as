package com.yiTian.view.modules.Kunlun
{
   import com.ui.controls.Button;
   import com.ui.controls.IconButton;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.command.IBindViewer;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_kunlun;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.SceneConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KLMountianCGMessage;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getTimer;
   
   public class View_enterArea extends Panel implements IBindViewer
   {
      
      private var _btnVec:Vector.<IconButton>;
      
      private var tf_tip:TextField;
      
      private var _btnPre:Button;
      
      private var _btnNxt:Button;
      
      private var _tfCurIndex:MyTextField;
      
      private var bg:DisplayObjectContainer;
      
      private var last1:int = -2000;
      
      private var _obj:Object;
      
      private var _curPage:int = 0;
      
      private var isUIComplete:Boolean = false;
      
      private var last:int = -2000;
      
      public function View_enterArea()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg = new Sprite();
         this.bg.mouseEnabled = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":658,
            "height":523
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":this.bg.width - 30,
            "y":6
         },Global.Img_Cdm);
         this.tf_tip = ComponentUtil.getTextField("",this,{
            "x":36,
            "y":470,
            "color":14540253
         });
         this.tf_tip.text = LangConfig.getWord("22360",2);
         this._btnVec = new Vector.<IconButton>();
         this._tfCurIndex = ComponentUtil.getTextField("1/1",this,{
            "x":480,
            "y":470,
            "realWidth":60
         });
         this._tfCurIndex.autoSize = TextFieldAutoSize.CENTER;
         this._btnPre = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":460,
            "y":470
         },Global.Img_Cdm);
         this._btnNxt = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":541,
            "y":470
         },Global.Img_Cdm);
      }
      
      private function preHd(evt:MouseEvent) : void
      {
         this.changePage(this._curPage - 1);
      }
      
      private function nxtHd(evt:MouseEvent) : void
      {
         this.changePage(this._curPage + 1);
      }
      
      private function btnHd(evt:MouseEvent) : void
      {
         var btn:Button = null;
         var obj:Object = null;
         var arr:Array = null;
         var num:int = 0;
         var now:int = 0;
         if(evt.target is Button)
         {
            btn = evt.target as Button;
            if(btn.tabIndex != -1)
            {
               if(btn.enabled == false)
               {
                  return;
               }
               obj = Model_kunlun.myKLInfo.getData();
               if(obj.myIndex == btn.tabIndex)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("22346",2));
                  return;
               }
               arr = Model_kunlun.klRoomInfo.getData().array as Array;
               num = int(arr[btn.tabIndex]);
               if(num >= Enum_kunLun.NUM_MAX_PLAYER)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("22347",2));
                  return;
               }
               now = getTimer();
               if(now - this.last1 > 1000)
               {
                  KLMountianCGMessage.CG_CHANGE_KL_ROON(btn.tabIndex);
                  this.last1 = now;
               }
            }
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         Model_kunlun.klRoomInfo.setBindViewer(UIManager.kl_roomInfo);
         addEventListener(MouseEvent.CLICK,this.btnHd);
         this._btnPre.callBack = this.preHd;
         this._btnNxt.callBack = this.nxtHd;
         Global.control.registerCallBack(Enum_MsgType.MSG_LEAVEFB_BTN,this.cb);
      }
      
      private function cb(obj:Object) : void
      {
         if(SceneConfig.getSceneType() == SceneConfig.KUNLUN)
         {
            View_Alert.show(LangConfig.getWord("22359",2),View_Alert.OK_CANCAL,function():void
            {
               KLMountianCGMessage.CG_KL_LEAVE();
            });
         }
      }
      
      public function update(obj:Object) : void
      {
         if(this._btnVec.length == 0)
         {
            return;
         }
         this._obj = obj;
         var count:int = int(obj.array.length);
         this.changePage(this._curPage);
      }
      
      private function changePage(index:int) : void
      {
         if(!Model_kunlun.klRoomInfo.getData())
         {
            return;
         }
         if(index < 0 || !this._obj)
         {
            return;
         }
         var count:int = int(this._obj.array.length);
         var maxPage:int = int(this._obj.array.length / 35);
         if(count > 0 && count % 35 == 0)
         {
            maxPage -= 1;
         }
         if(index > maxPage)
         {
            this._curPage = maxPage;
            this.setPage(maxPage);
            return;
         }
         this._curPage = index;
         this.setPage(index);
         this._tfCurIndex.text = (this._curPage + 1).toString() + "/" + (maxPage + 1).toString();
      }
      
      private function addBmAtBtn(btn:IconButton) : void
      {
         var bm:Bitmap = null;
         if(btn.name == "-1")
         {
            bm = Utils.getSwfBitmap("modelRes/pic_swf/35076.swf");
            bm.x = -11;
            bm.y = -16;
            btn.addChild(bm);
            btn.name = "1";
         }
      }
      
      private function removeBmAtBtn(btn:IconButton) : void
      {
         if(btn.name == "1")
         {
            btn.removeChild(btn.getChildAt(btn.numChildren - 1));
            btn.name = "-1";
         }
      }
      
      private function setPage(index:int) : void
      {
         var str:String = null;
         if(!Model_kunlun.klRoomInfo.getData())
         {
            return;
         }
         var startIndex:int = index * 35;
         var max:int = this._obj.array.length - startIndex;
         var i:int = 0;
         while(i < 35)
         {
            if(i < max)
            {
               if(this._obj.array[i] >= Enum_kunLun.NUM_MAX_PLAYER)
               {
                  str = LangConfig.getWord("29099",2);
                  this.addBmAtBtn(this._btnVec[i]);
               }
               else
               {
                  str = "<font color=\'#44DDFF\'>(" + Enum_BroadCastTool.instance.getBitStr((this._obj.array as Array)[i]) + "/" + Enum_kunLun.NUM_MAX_PLAYER.toString() + ")</font>";
                  this.removeBmAtBtn(this._btnVec[i]);
               }
               this._btnVec[i].label = LangConfig.getWord("23403",2) + Enum_BroadCastTool.instance.getBitStr(startIndex + i + 1) + "\n" + str;
               this._btnVec[i].enabled = true;
               this._btnVec[i].tabIndex = startIndex + i;
            }
            else
            {
               this._btnVec[i].label = LangConfig.getWord("29100",2);
               this._btnVec[i].tabIndex = -1;
               this._btnVec[i].enabled = false;
               this.removeBmAtBtn(this._btnVec[i]);
            }
            i += 1;
         }
      }
      
      private function createBtn(count:int) : void
      {
         var Y1:Number = NaN;
         var offsetY:Number = NaN;
         var i:int = 0;
         var btn:IconButton = null;
         var icon:Bitmap = null;
         Y1 = 54;
         offsetY = 57;
         i = 0;
         while(i < count)
         {
            btn = ComponentUtil.getIconButton("","Button_HeWan",null,null,Global.Img_Cdm);
            btn.name = "-1";
            btn.labelTF.align = "center";
            icon = ComponentUtil.getBitmap("KunLun_Icon",null,{
               "x":8,
               "y":8
            },Global.KunLun_Imgsdm);
            btn.icon = icon;
            btn.setLabelOffset(35,0);
            btn.tabIndex = -1;
            if(i == 0)
            {
               btn.enabled = true;
            }
            else
            {
               btn.enabled = false;
            }
            btn.x = 34 + 120 * (i % 5);
            btn.y = Y1 + offsetY * int(i / 5);
            this._btnVec.push(btn);
            addChild(btn);
            i += 1;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var v:Boolean;
         var v2:Boolean;
         var v3:Boolean;
         var now:int = 0;
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.KunLun_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/KunLun_Imgs.swf",function(info:Object):void
                  {
                     Global.KunLun_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
            now = getTimer();
            if(now - this.last > 2000)
            {
               KLMountianCGMessage.CG_GET_KL_ROOM();
               this.last = now;
            }
         }
         v = super.visible;
         super.visible = value;
         v2 = super.visible;
         v3 = visible;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this.bg,{
            "x":24,
            "y":41,
            "width":610,
            "height":473
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Room",this.bg,{
            "x":249,
            "y":5
         },Global.KunLun_Imgsdm);
         this.createBtn(35);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - this.bg.width) / 2;
         y = (Global.stage.stageHeight - this.bg.height) / 2;
      }
   }
}

