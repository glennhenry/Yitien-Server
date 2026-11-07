package com.yiTian.view.modules.friends
{
   import com.utils.ColorConstant;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.gameUnit.role.LZBmp;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.modules.newRolePan.View_rolePan;
   import com.yiTian.view.modules.wuXing.WuXingMter;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class Child_FriendItem extends Sprite
   {
      
      public static var selectedTarget:Child_FriendItem;
      
      private static const maskY:Number = 20;
      
      private var tf_friendName:TextField;
      
      private var bm_icon:Bitmap;
      
      public var itemParent:Object;
      
      public var isEnabled:Boolean = true;
      
      public var vo_info:Vo_unit;
      
      private var mouseArea:Sprite;
      
      private var bg:Shape;
      
      private var item:Item;
      
      private var maskX:Number = 136;
      
      private var isOver:Boolean = false;
      
      private var isSelected:Boolean = false;
      
      private var buff:String;
      
      private var j:int = 1;
      
      private var LZbmp:LZBmp = new LZBmp();
      
      private var lastClickTime:int = 0;
      
      public function Child_FriendItem(data:Vo_unit, itemParent:Object)
      {
         var str:String = null;
         super();
         this.bg = new Shape();
         addChild(this.bg);
         this.visible = visible;
         this.vo_info = data;
         this.bm_icon = new Bitmap();
         this.judge();
         str = "resource/image/friend/fri_Icon_0" + this.j + ".png";
         this.item = new Item();
         this.item.x = 145;
         this.item.y = 2;
         this.item.getBmp(str);
         var s1:String = LangConfig.getWord("29249",2) + this.vo_info.qinmidu;
         var s2:String = LangConfig.getWord("29250",2) + Enum_Friend.getTXT(this.vo_info.qinmidu);
         var s3:String = LangConfig.getWord("29251",2) + this.buff;
         var s4:String = LangConfig.getWord("29252",2);
         TipManager.bind(this.item,s1 + s2 + s3 + s4);
         this.itemParent = itemParent;
         this.tf_friendName = new TextField();
         this.tf_friendName.x = 25;
         this.tf_friendName.height = 20;
         this.tf_friendName.width = 166;
         this.tf_friendName.selectable = false;
         addChild(this.tf_friendName);
         this.bm_icon.y = 2;
         this.bm_icon.x = 2;
         addChild(this.bm_icon);
         this.update(this.vo_info);
         this.mouseArea = new Sprite();
         this.mouseArea.graphics.beginFill(8947848,0);
         this.mouseArea.graphics.drawRect(0,0,this.maskX,maskY);
         this.mouseArea.graphics.endFill();
         addChild(this.mouseArea);
         if(this.vo_info.isOnline == false)
         {
            this.setOffLineType();
         }
         addEventListener(MouseEvent.MOUSE_MOVE,this.rollOverHandle);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOutHandle);
         addEventListener(MouseEvent.CLICK,this.mouseClickHandle);
         if(this.vo_info.relation == 1 || this.vo_info.relation == Enum_Friend.CROSS_SERV_FRIEND)
         {
            this.item.visible = true;
         }
         else
         {
            this.item.visible = false;
         }
         addChild(this.LZbmp);
         addChildAt(this.item,numChildren - 1);
         this.LZbmp.y = 2;
      }
      
      public static function doneSelectedTarget() : void
      {
         if(Boolean(selectedTarget))
         {
            selectedTarget.setMouseOutBg();
         }
      }
      
      public function update(data:Vo_unit) : void
      {
         var str_icon:String = Const_strImg.getPlayerHead(this.vo_info.job,this.vo_info.sex,3);
         Utils.getLoadBitmap(str_icon,this.bm_icon,null,function():void
         {
            if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Global.pf == Enum_SPStr.QQGAME || Global.pf == Enum_SPStr.QQJIA || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf) || Enum_SPStr.isIwan(Global.pf))
            {
               addDia(vo_info.diaLvl,vo_info.isYearDia,vo_info.huangZLvl,vo_info.isHuangZYear,vo_info.isHuiyuan,vo_info.isHuiyuanYear,vo_info.superLan,vo_info.superLanYear,vo_info.isSuperHuang);
            }
         });
         if(data.id == GameUnitManager.hero.marriageID)
         {
            this.tf_friendName.htmlText = HtmlUtil.font(data.name,ColorConstant.getColorStr(ColorConstant.RED),12);
         }
         else
         {
            this.tf_friendName.htmlText = HtmlUtil.font(data.name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
         }
      }
      
      public function setMarriage() : void
      {
         var color:String = null;
         if(Boolean(this.vo_info) && this.vo_info.id == GameUnitManager.hero.marriageID)
         {
            color = this.vo_info.isOnline ? ColorConstant.getColorStr(ColorConstant.RED) : ColorConstant.getColorStr(ColorConstant.WHITE);
            this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,color,12);
         }
         else if(Boolean(this.vo_info) && GameUnitManager.hero.marriageID == 0)
         {
            this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
         }
      }
      
      public function addDia(diaLvl:int, isYearDia:int, huangZLv:int = 0, isYearHuangZ:int = 0, huiyuan:int = 0, huiyuanYear:int = 0, superLan:int = 0, superLanYear:int = 0, isSuperHuang:int = 0) : void
      {
         this.LZbmp.bitmapData = null;
         this.tf_friendName.x = 25;
         this.maskX = 136;
         this.item.x = 145;
         if(Global.pf == "qqgame" || Global.pf == Enum_SPStr.QQ3366)
         {
            if(superLanYear == 0 && superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLan(superLan),this.LZbmp.bmp,null,this.align);
               return;
            }
            if(superLan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getsuperLanYear(superLan),this.LZbmp.bmp,null,this.align);
               return;
            }
            if(isYearDia == 0 && diaLvl > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl(diaLvl),this.LZbmp.bmp,null,this.align);
            }
            else if(diaLvl > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl(diaLvl),this.LZbmp.bmp,null,this.align);
            }
         }
         else if(Global.pf == "qplus" || Global.pf == Enum_SPStr.GUANWANG || Enum_SPStr.isUnion(Global.pf))
         {
            if(huiyuanYear == 0 && huiyuan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getQQHuiYuan(huiyuan),this.LZbmp.bmp,null,this.align);
            }
            else if(huiyuan > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getQQHuiYuanYear(huiyuan),this.LZbmp.bmp,null,this.align);
            }
         }
         else if(Global.pf == Enum_SPStr.PENGYOU || Global.pf == Enum_SPStr.QZONE || Enum_SPStr.isIwan(Global.pf))
         {
            if(Boolean(isSuperHuang))
            {
               if(isYearHuangZ == 0 && huangZLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl_superH(huangZLv),this.LZbmp.bmp,null,this.align);
               }
               else if(huangZLv > 0)
               {
                  this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl_superH(huangZLv),this.LZbmp.bmp,null,this.align);
               }
            }
            else if(isYearHuangZ == 0 && huangZLv > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getLvlUrl_h(huangZLv),this.LZbmp.bmp,null,this.align);
            }
            else if(huangZLv > 0)
            {
               this.LZbmp.bmp = Utils.getLoadBitmap(LZBmp.getYearUrl_h(huangZLv),this.LZbmp.bmp,null,this.align);
            }
         }
      }
      
      private function align() : void
      {
         this.LZbmp.x = this.bm_icon.x + this.bm_icon.width + 2;
         this.tf_friendName.x = this.LZbmp.x + this.LZbmp.width;
         this.maskX = 136 + 8;
      }
      
      public function setOffLineType() : void
      {
         this.isEnabled = false;
         this.vo_info.isOnline = false;
         if(this.vo_info.id == GameUnitManager.hero.marriageID)
         {
            this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,ColorConstant.getColorStr(ColorConstant.WHITE),12);
         }
         this.bm_icon.filters = Util.disabled;
         this.tf_friendName.filters = Util.disabled;
      }
      
      public function isOnline() : Boolean
      {
         return this.vo_info.isOnline;
      }
      
      public function setOnLineType() : void
      {
         this.isEnabled = true;
         this.vo_info.isOnline = true;
         if(this.vo_info.id == GameUnitManager.hero.marriageID)
         {
            this.tf_friendName.htmlText = HtmlUtil.font(this.vo_info.name,ColorConstant.getColorStr(ColorConstant.RED),12);
         }
         this.bm_icon.filters = [];
         this.tf_friendName.filters = [];
      }
      
      public function updataQinMi() : void
      {
         var s1:String;
         var s2:String;
         var s3:String;
         var s4:String;
         var str:String;
         var ringID:int = 0;
         this.judge();
         s1 = LangConfig.getWord("29249",2) + this.vo_info.qinmidu;
         s2 = LangConfig.getWord("29250",2) + Enum_Friend.getTXT(this.vo_info.qinmidu);
         s3 = LangConfig.getWord("29251",2) + this.buff;
         s4 = LangConfig.getWord("29252",2);
         TipManager.bind(this.item,s1 + s2 + s3 + s4);
         str = "resource/image/friend/fri_Icon_0" + this.j + ".png";
         this.item.getBmp(str);
         if(this.vo_info.id == GameUnitManager.hero.marriageID)
         {
            ringID = GameUnitManager.hero.marriageRing;
            WuXingMter.getPan(View_rolePan,function(pan:View_rolePan):void
            {
               pan.updateRing(ringID,vo_info.qinmidu,vo_info.name);
            });
         }
      }
      
      public function judge() : void
      {
         if(this.vo_info.qinmidu <= 300)
         {
            this.j = 1;
         }
         else if(this.vo_info.qinmidu <= 700)
         {
            this.j = 3;
         }
         else if(this.vo_info.qinmidu <= 1500)
         {
            this.j = 4;
         }
         else if(this.vo_info.qinmidu <= 3100)
         {
            this.j = 5;
         }
         else if(this.vo_info.qinmidu > 3100)
         {
            this.j = 2;
         }
         if(this.vo_info.qinmidu <= 100)
         {
            this.buff = LangConfig.getWord("60111",6);
         }
         else if(this.vo_info.qinmidu <= 300)
         {
            this.buff = LangConfig.getWord("60112",6);
         }
         else if(this.vo_info.qinmidu <= 700)
         {
            this.buff = LangConfig.getWord("60113",6);
         }
         else if(this.vo_info.qinmidu <= 1500)
         {
            this.buff = LangConfig.getWord("60114",6);
         }
         else if(this.vo_info.qinmidu <= 3100)
         {
            this.buff = LangConfig.getWord("60115",6);
         }
         else if(this.vo_info.qinmidu <= 6300)
         {
            this.buff = LangConfig.getWord("60116",6);
         }
         else if(this.vo_info.qinmidu <= 12700)
         {
            this.buff = LangConfig.getWord("60117",6);
         }
         else if(this.vo_info.qinmidu <= 25500)
         {
            this.buff = LangConfig.getWord("60118",6);
         }
         else if(this.vo_info.qinmidu > 25500)
         {
            this.buff = LangConfig.getWord("60119",6);
         }
      }
      
      public function choose() : void
      {
         doneSelectedTarget();
         selectedTarget = this;
         this.setSelectedBg();
      }
      
      private function doubleClickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(GameUnitManager.hero.level < 30)
         {
            UIManager.centerBroadcast.addMsg("亲，您还未到30级不能私聊");
            return;
         }
         if(this.vo_info.relation == Enum_Friend.CROSS_SERV_FRIEND || this.vo_info.relation == Enum_Friend.CROSS_SERV_HEAT)
         {
            ChatCGMessage.CG_KUAFU_CHAT(this.vo_info.id,this.vo_info.name);
         }
         else
         {
            if(this.vo_info.isOnline == false)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("23100",2));
               return;
            }
            ChatCGMessage.CG_SID_CHAT(this.vo_info.id);
         }
      }
      
      private function mouseClickHandle(evt:MouseEvent) : void
      {
         var ins:View_FriendSelectedMenu = null;
         var curTime:int = getTimer();
         ins = View_FriendSelectedMenu.getInstance();
         evt.stopPropagation();
         if(curTime - this.lastClickTime < 300)
         {
            if(ins.visible)
            {
               ins.visible = false;
            }
            this.lastClickTime = curTime;
            this.doubleClickHandle(evt);
            return;
         }
         this.lastClickTime = curTime;
         ins.visible = !ins.visible;
         var p:Point = localToGlobal(new Point(mouseX,mouseY));
         ins.x = p.x + 3;
         ins.y = p.y + 3;
         if(ins.y + ins.height >= Global.stage.stageHeight)
         {
            ins.y = p.y + 3 - ins.height;
         }
         if(ins.x + ins.width >= Global.stage.stageWidth)
         {
            ins.x = p.x + 3 - ins.width;
         }
         if(this.vo_info.relation == 1)
         {
            ins.setFrienSelectedItem();
         }
         else if(this.vo_info.relation == 2)
         {
            ins.setHeatSelectedItem();
         }
         else if(this.vo_info.relation == Enum_Friend.QFRIEND)
         {
            ins.setQQSelectedItem();
         }
         else if(this.vo_info.relation == Enum_Friend.CROSS_SERV_FRIEND)
         {
            ins.setCrossFriend();
         }
         else if(this.vo_info.relation == Enum_Friend.CROSS_SERV_HEAT)
         {
            ins.setCrossHeat();
         }
         GameScene.uiLayer.addChild(ins);
         View_FriendSelectedMenu.getInstance().data = this.vo_info;
         doneSelectedTarget();
         selectedTarget = this;
         this.setSelectedBg();
      }
      
      private function rollOverHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(!this.isSelected)
         {
            this.setMouseOverBg();
         }
         if(mouseX > this.maskX)
         {
            return;
         }
         if(mouseX > this.maskX && this.vo_info.relation == Enum_Friend.QFRIEND)
         {
            TipManager.update(this.vo_info.qinmidu > 0 ? LangConfig.getWord("29238",2) : LangConfig.getWord("29239",2));
         }
         else
         {
            TipManager.update(this.vo_info);
         }
      }
      
      private function rollOutHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         if(!this.isSelected)
         {
            this.setMouseOutBg();
         }
         TipManager.hide();
      }
      
      public function dispose() : void
      {
         this.mouseArea.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverHandle);
         this.mouseArea.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutHandle);
         this.mouseArea.removeEventListener(MouseEvent.CLICK,this.mouseClickHandle);
         this.vo_info = null;
         this.itemParent = null;
         removeChild(this.tf_friendName);
         removeChild(this.bm_icon);
         removeChild(this.mouseArea);
         removeChild(this.bg);
      }
      
      private function setSelectedBg() : void
      {
         this.isSelected = true;
         this.bg.graphics.beginFill(14135320,0.7);
         this.bg.graphics.drawRect(0,0,this.maskX,maskY);
         this.bg.graphics.endFill();
      }
      
      private function setMouseOverBg() : void
      {
         this.bg.graphics.beginFill(5609898,0.7);
         this.bg.graphics.drawRect(0,0,this.maskX,maskY);
         this.bg.graphics.endFill();
      }
      
      private function setMouseOutBg() : void
      {
         this.isSelected = false;
         this.bg.graphics.clear();
      }
   }
}

import com.yiTian.utils.Utils;
import flash.display.Bitmap;
import flash.display.Sprite;

class Item extends Sprite
{
   
   private var bmp:Bitmap;
   
   public function Item()
   {
      super();
      this.bmp = new Bitmap();
      addChild(this.bmp);
   }
   
   public function getBmp(source:String) : void
   {
      if(Boolean(this.bmp))
      {
         this.bmp.bitmapData = null;
      }
      this.bmp = Utils.getLoadBitmap(source,this.bmp);
   }
}
