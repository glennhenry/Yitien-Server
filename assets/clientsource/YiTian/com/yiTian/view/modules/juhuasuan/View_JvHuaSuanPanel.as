package com.yiTian.view.modules.juhuasuan
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.JvHuaSuanCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class View_JvHuaSuanPanel extends Panel123
   {
      
      private static var _instance:View_JvHuaSuanPanel;
      
      public static var ID_INDEX:int = -1;
      
      public static var ADDCOUNTS:int = 0;
      
      public static var ALL_GIFT_BUY:String = "allGiftBuy";
      
      public static var ALL_MONEY:int = 0;
      
      private var _itemArr:Array;
      
      private var _closeBtn:Button;
      
      private var _initt:Boolean = false;
      
      private var _allAwardBtn:Button;
      
      private var _awardLabelArr:Array = ["全部购买","立即领取","已领取"];
      
      private var allStatus:int = 0;
      
      private var _vo:Vo_JuHuaSuan;
      
      private var _grid:View_Grid;
      
      private var allItemId:int;
      
      private var _expId:int;
      
      private var _allBuyBtn:Button;
      
      private var _canvas:Canvas;
      
      private var _eff:Effect;
      
      public function View_JvHuaSuanPanel()
      {
         super();
         if(Boolean(_instance))
         {
            return;
         }
         regResource("lang/ch/JuHuaSuan.swf","JHSdm");
      }
      
      public static function get instance() : View_JvHuaSuanPanel
      {
         if(!_instance)
         {
            _instance = new View_JvHuaSuanPanel();
         }
         return _instance;
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var item:SingleItem = null;
         move = new Rectangle(0,0,769,38);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":769,
            "height":500
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_InfList",[3,3,16,16],this,{
            "x":25,
            "y":40,
            "width":719,
            "height":450
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_XJGD",[4,4,1,1],this,{
            "x":37,
            "y":52,
            "width":283,
            "height":426
         },Global.JHSdm);
         ComponentUtil.getBitmap("Back_JHS",this,{
            "x":324,
            "y":52
         },Global.JHSdm);
         ComponentUtil.getBitmap("Title_JHS",this,{
            "x":304,
            "y":5
         },Global.JHSdm);
         ComponentUtil.getBitmap("Text_DYH",this,{
            "x":324,
            "y":258
         },Global.JHSdm);
         ComponentUtil.getBitmap("Text_GMLB",this,{
            "x":497,
            "y":88
         },Global.JHSdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":414,
            "y":395
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Text_QBGM",this,{
            "x":365,
            "y":366
         },Global.JHSdm);
         this._itemArr = [];
         var len:int = int(Data_lib.jvhuasuan.getLength());
         if(len > 7)
         {
            if(!this._canvas)
            {
               this._canvas = new Canvas(275,420);
               addChild(this._canvas);
               this._canvas.x = 41;
               this._canvas.y = 55;
               this._canvas.scrollAutoType = ScrollAutoType.REMAIN;
            }
         }
         i = 0;
         while(i < len)
         {
            item = new SingleItem();
            if(Boolean(this._canvas))
            {
               this._canvas.addChild(item);
               item.x = 0;
               item.y = 60 * i;
            }
            else
            {
               addChild(item);
               item.x = 41;
               item.y = 60 * i + 55;
            }
            this._itemArr.push(item);
            i++;
         }
         if(Boolean(this._canvas))
         {
            this._canvas.reset();
            this._canvas.align();
         }
         this._grid = new View_Grid(true);
         this._grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this._grid.set_bmp_over(true,null);
         this._grid.set_tf_count(true,false,true);
         addChild(this._grid);
         ComponentUtil.setPropertie(this._grid,{
            "x":414,
            "y":395
         });
         this._allAwardBtn = ComponentUtil.getButton("","Button_LJLQ",this,{
            "x":536,
            "y":406,
            "textColor":16771436
         },Global.JHSdm);
         this._allAwardBtn.callBack = this.allGetAward;
         this._allAwardBtn.visible = false;
         this._allBuyBtn = ComponentUtil.getButton("","Button_QBGM",this,{
            "x":536,
            "y":406,
            "textColor":16771436
         },Global.JHSdm);
         this._allBuyBtn.callBack = this.allGetAward;
         this._closeBtn = ComponentUtil.getButton("","Button_Close",this,{
            "x":734,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this._closeBtn.callBack = this.closeMenu;
         this.allItemId = Data_lib.jvhuasuan[1][7];
         this._initt = true;
         if(Boolean(this._vo))
         {
            this.updateData(this._vo);
         }
         Global.control.registerCallBack(View_JvHuaSuanPanel.ALL_GIFT_BUY,this.onBuyAll);
      }
      
      private function onBuyAll() : void
      {
         var i:int = 0;
         if(Boolean(this._vo))
         {
            this._vo.allStatus = 2;
            i = 0;
            while(i < this._vo.btnArr.length)
            {
               if(this._vo.btnArr[i] == 1)
               {
                  this._vo.btnArr[i] = 2;
               }
               i++;
            }
            this.updateData(this._vo);
         }
      }
      
      private function allGetAward(e:MouseEvent) : void
      {
         View_JvHuaSuanPanel.ID_INDEX = 0;
         if(this.allStatus == 1)
         {
            if(Boolean(this._vo))
            {
               if(GameUnitManager.hero.money < View_JvHuaSuanPanel.ALL_MONEY)
               {
                  UIManager.centerBroadcast.addMsg("元宝不足，无法购买礼包");
                  return;
               }
               View_Alert.show("<font color=\'#ffffff\'>确定要花费<font color=\'#ffff00\'>" + View_JvHuaSuanPanel.ALL_MONEY + "</font>元宝购买全部特权礼包？</font>",View_Alert.OK_CANCAL,function():void
               {
                  JvHuaSuanCGMessage.CG_JHS_BUY(_expId);
               });
            }
         }
         else if(this.allStatus == 2)
         {
            JvHuaSuanCGMessage.CG_JHS_GETAWARD(this._expId);
         }
      }
      
      private function closeMenu(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function updateData(vo:Vo_JuHuaSuan) : void
      {
         var libaoId:int = 0;
         var libaoName:String = null;
         var yuanbaoNum:int = 0;
         var count:int = 0;
         this._vo = vo;
         if(!this._initt)
         {
            return;
         }
         ADDCOUNTS = 0;
         var len:int = int(this._vo.btnArr.length);
         this.allStatus = this._vo.allStatus;
         this._expId = this._vo.expId;
         View_JvHuaSuanPanel.ALL_MONEY = this._vo.allYuanBao;
         var dictionary:DictionaryTabel = Data_lib.jvhuasuan;
         var i:int = 0;
         while(i < len)
         {
            libaoId = int(dictionary[i + 1][4]);
            yuanbaoNum = int(dictionary[i + 1][2]);
            libaoName = dictionary[i + 1][3];
            count = int(dictionary[i + 1][0].split("_")[2]);
            this._itemArr[i].updateData(this._vo.idArr[i],this._vo.daysArr[i],this._vo.btnArr[i],libaoId,count,libaoName,yuanbaoNum);
            i++;
         }
         var vo_item:Vo_item = new Vo_item();
         vo_item.id = this.allItemId;
         vo_item.Init_lib();
         vo_item.bBind = true;
         this._grid.vo = vo_item;
         if(!this._eff)
         {
            this._eff = EffectManager.addEffect("35180",this._grid,1000,32,32,true);
         }
         if(this.allStatus == 1)
         {
            this._allAwardBtn.visible = false;
            this._allBuyBtn.visible = true;
         }
         else if(this.allStatus == 2)
         {
            this._allBuyBtn.visible = false;
            this._allAwardBtn.visible = true;
            this._allAwardBtn.enabled = true;
         }
         else if(this.allStatus == 3)
         {
            this._allBuyBtn.visible = false;
            this._allAwardBtn.visible = true;
            this._allAwardBtn.enabled = false;
         }
         else if(this.allStatus == 4)
         {
            this._allBuyBtn.visible = true;
            this._allBuyBtn.enabled = false;
            this._allAwardBtn.visible = false;
            this._allAwardBtn.enabled = false;
         }
      }
      
      public function getBuyResult() : void
      {
         var idx:int = 0;
         if(View_JvHuaSuanPanel.ID_INDEX == 0)
         {
            this.allStatus = 2;
            this.onBuyAll();
         }
         else if(View_JvHuaSuanPanel.ID_INDEX > 0)
         {
            idx = View_JvHuaSuanPanel.ID_INDEX - 1;
            this._itemArr[idx].getBuyResult();
         }
      }
      
      public function getAward() : void
      {
         var itemStr:String = null;
         var itemArr:Array = null;
         var voArr:Array = null;
         var i:int = 0;
         var count:int = 0;
         var singleArr:Array = null;
         var type:int = 0;
         var id:int = 0;
         var clearId:int = 0;
         var vo_item:Vo_item = null;
         var vo_equip:Vo_equip = null;
         var tempfun:Function = null;
         var idx:int = 0;
         if(View_JvHuaSuanPanel.ID_INDEX == 0)
         {
            this._allAwardBtn.enabled = false;
            this.allStatus = 3;
            itemStr = Data_lib.jvhuasuan[1][5];
            itemArr = itemStr.split(",");
            voArr = [];
            i = 0;
            while(i < itemArr.length)
            {
               singleArr = itemArr[i].split("_");
               type = int(singleArr[0]);
               id = int(singleArr[1]);
               if(type == 1)
               {
                  vo_item = new Vo_item();
                  vo_item.id = id;
                  vo_item.Init_lib();
                  vo_item.bBind = true;
                  voArr.push(vo_item);
               }
               else if(type == 2)
               {
                  vo_equip = new Vo_equip();
                  vo_equip.id = id;
                  vo_equip.Init_lib();
                  vo_equip.bBind = true;
                  voArr.push(vo_equip);
               }
               i++;
            }
            count = 0;
            if(Boolean(voArr.length))
            {
               tempfun = function():void
               {
                  var p:Point = _grid.localToGlobal(new Point(0,0));
                  clearTimeout(clearId);
                  if(count < voArr.length)
                  {
                     ComboTweenStep.toBag(voArr[count],p.x,p.y);
                     ++count;
                     clearId = setTimeout(tempfun,100);
                  }
               };
               clearId = int(setTimeout(tempfun,100));
            }
         }
         else if(View_JvHuaSuanPanel.ID_INDEX > 0)
         {
            idx = View_JvHuaSuanPanel.ID_INDEX - 1;
            if(Boolean(this._vo))
            {
               ++this._vo.daysArr[idx];
               this._vo.btnArr[idx] = 3;
            }
            this._itemArr[idx].getAward(this._vo.daysArr[idx]);
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            JvHuaSuanCGMessage.CG_JHS_OPEN();
         }
         else if(Boolean(this._eff))
         {
            EffectManager.removeEffect(this._eff);
            this._eff = null;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 793) / 2;
         y = (Global.stage.stageHeight - 500) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ColorConstant;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.data.config.valuable.Enum_color;
import com.yiTian.data.vo.Vo_equip;
import com.yiTian.data.vo.Vo_item;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.JvHuaSuanCGMessage;
import com.yiTian.utils.ComboTweenStep;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.juhuasuan.View_JvHuaSuanPanel;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

class SingleItem extends Sprite
{
   
   private var _grid:View_Grid;
   
   private var _libaoName:MyTextField;
   
   private var _index:int;
   
   private var _yuanbaoTF:MyTextField;
   
   private var _button:Button;
   
   private var _state:int = 0;
   
   private var labelArr:Array = ["购买","可领取","已领取"];
   
   private var _yuaobaoNum:int;
   
   private var initDes:String;
   
   public function SingleItem()
   {
      super();
      this.initItem();
   }
   
   private function initItem() : void
   {
      ComponentUtil.getBitmap("Back_WPDK",this,{
         "x":0,
         "y":0
      },Global.JHSdm);
      this._grid = new View_Grid();
      this._grid.set_bmp_bg();
      this._grid.set_bmp_over(true,null);
      this._grid.set_tf_count(true,false,true);
      addChild(this._grid);
      ComponentUtil.setPropertie(this._grid,{
         "x":14,
         "y":13
      });
      this._libaoName = ComponentUtil.getTextField("",this,{
         "x":59,
         "y":7,
         "color":16755712,
         "size":14,
         "leading":0
      });
      this._yuanbaoTF = ComponentUtil.getTextField("",this,{
         "x":59,
         "y":30,
         "color":16776960,
         "size":12,
         "leading":0
      });
      this._button = ComponentUtil.getButton(this.labelArr[0],"Button_GouMai",this,{
         "x":180,
         "y":17,
         "textColor":16771436
      },Global.JHSdm);
      this._button.callBack = this.onButtonClick;
      this._button.enabled = false;
   }
   
   private function onButtonClick(e:MouseEvent) : void
   {
      View_JvHuaSuanPanel.ID_INDEX = this._index;
      switch(this._state)
      {
         case 1:
            if(GameUnitManager.hero.money < this._yuaobaoNum)
            {
               UIManager.centerBroadcast.addMsg("元宝不足，无法购买礼包");
               return;
            }
            View_Alert.show("<font color=\'#ffffff\'>确定要花费<font color=\'#ffff00\'>" + this._yuaobaoNum + "</font>元宝购买" + this._libaoName.text + "？</font>",View_Alert.OK_CANCAL,function():void
            {
               JvHuaSuanCGMessage.CG_JHS_BUY(_index);
            });
            break;
         case 2:
            JvHuaSuanCGMessage.CG_JHS_GETAWARD(this._index);
      }
   }
   
   public function updateData(index:int, days:int, state:int, libaoId:int, count:int, libaoName:String, yuanbaoNum:int) : void
   {
      this._index = index;
      this._state = state;
      this._yuaobaoNum = yuanbaoNum;
      this._libaoName.text = libaoName;
      this._yuanbaoTF.text = yuanbaoNum + "元宝";
      switch(this._state)
      {
         case 1:
            this._button.label = this.labelArr[0];
            this._button.enabled = true;
            break;
         case 2:
            this._button.label = this.labelArr[1];
            this._button.enabled = true;
            ++View_JvHuaSuanPanel.ADDCOUNTS;
            break;
         case 3:
            this._button.label = this.labelArr[2];
            this._button.enabled = false;
            break;
         case 4:
            this._button.label = this.labelArr[0];
            this._button.enabled = false;
      }
      var vo_item:Vo_item = new Vo_item();
      vo_item.id = libaoId;
      vo_item.count = count;
      vo_item.Init_lib();
      vo_item.bBind = true;
      vo_item.bgIndex = Data_lib.jvhuasuan[index][8];
      this.initDes = vo_item.str_describe;
      vo_item.str_describe = LangConfig.reTxt(this.initDes,days);
      this._grid.vo = vo_item;
      var color1:int = 0;
      if(vo_item.color == Enum_color.WHITE)
      {
         color1 = ColorConstant.getColorInt(ColorConstant.WHITE);
      }
      else if(vo_item.color == Enum_color.GREEN)
      {
         color1 = ColorConstant.getColorInt(ColorConstant.GREEN);
      }
      else if(vo_item.color == Enum_color.BLUE)
      {
         color1 = ColorConstant.getColorInt(ColorConstant.BLUE);
      }
      else if(vo_item.color == Enum_color.PURPLE)
      {
         color1 = ColorConstant.getColorInt(ColorConstant.PURPLE);
      }
      else if(vo_item.color == Enum_color.ORANGE)
      {
         color1 = ColorConstant.getColorInt(ColorConstant.ORANGE);
      }
      else if(vo_item.color == Enum_color.ANJIN)
      {
         color1 = ColorConstant.getColorInt(ColorConstant.ANJIN);
      }
      this._libaoName.color = color1;
   }
   
   public function getAward(day:int) : void
   {
      var tempVo:Vo_item;
      var itemArr:Array;
      var i:int;
      var voArr:Array = null;
      var count:int = 0;
      var singleArr:Array = null;
      var type:int = 0;
      var id:int = 0;
      var clearId:int = 0;
      var vo_item:Vo_item = null;
      var vo_equip:Vo_equip = null;
      var tempfun:Function = null;
      this._button.enabled = false;
      this._button.label = this.labelArr[2];
      this._state = 3;
      tempVo = new Vo_item();
      tempVo.id = this._grid.vo.id;
      tempVo.count = this._grid.vo.count;
      tempVo.Init_lib();
      tempVo.bgIndex = this._grid.vo.bgIndex;
      this._grid.vo = tempVo;
      this._grid.vo.str_describe = LangConfig.reTxt(this.initDes,day);
      itemArr = Data_lib.jvhuasuan[this._index][0].split(",");
      voArr = [];
      i = 0;
      while(i < itemArr.length)
      {
         singleArr = itemArr[i].split("_");
         type = int(singleArr[0]);
         id = int(singleArr[1]);
         if(type == 1)
         {
            vo_item = new Vo_item();
            vo_item.id = id;
            vo_item.Init_lib();
            vo_item.bBind = true;
            voArr.push(vo_item);
         }
         else if(type == 2)
         {
            vo_equip = new Vo_equip();
            vo_equip.id = id;
            vo_equip.Init_lib();
            vo_equip.bBind = true;
            voArr.push(vo_equip);
         }
         i++;
      }
      count = 0;
      if(Boolean(voArr.length))
      {
         tempfun = function():void
         {
            var p:Point = _grid.localToGlobal(new Point(0,0));
            clearTimeout(clearId);
            if(count < voArr.length)
            {
               ComboTweenStep.toBag(voArr[count],p.x,p.y);
               ++count;
               clearId = setTimeout(tempfun,100);
            }
         };
         clearId = int(setTimeout(tempfun,100));
      }
   }
   
   public function getBuyResult() : void
   {
      this._button.enabled = true;
      this._button.label = this.labelArr[1];
      this._state = 2;
      ++View_JvHuaSuanPanel.ADDCOUNTS;
      View_JvHuaSuanPanel.ALL_MONEY -= this._yuaobaoNum;
      if(View_JvHuaSuanPanel.ADDCOUNTS >= 7)
      {
         Global.control.sendNotification(View_JvHuaSuanPanel.ALL_GIFT_BUY,null);
      }
   }
}
