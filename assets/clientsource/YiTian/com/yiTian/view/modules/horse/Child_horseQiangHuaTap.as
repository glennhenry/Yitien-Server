package com.yiTian.view.modules.horse
{
   import Layout.VGroup;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HorseCGMessage;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class Child_horseQiangHuaTap extends Sprite
   {
      
      private var _tfMaxLv:MyTextField;
      
      private var _tfNxtAtbMax:MyTextField;
      
      private var _gridNeedsItem:View_Grid;
      
      private var _tfSucceed:MyTextField;
      
      private var _tfLuck:MyTextField;
      
      private var _tfCost:MyTextField;
      
      private var _btnQiangHua:Button;
      
      public var _leftHorse:Child_tianTiUnit;
      
      private var _rightHorse:Child_tianTiUnit;
      
      private var _tfItemNum:MyTextField;
      
      private var _bg:DisplayObject;
      
      private var _curStarArr:Array = [];
      
      private var _nxtStarArr:Array = [];
      
      private var _tfCurAtbs:Array;
      
      private var _tfNxtAtbs:Array;
      
      private var _effBm:Bitmap;
      
      private var _needSilver:int;
      
      private var _needItemCount:int;
      
      private var _needItemId:int;
      
      public function Child_horseQiangHuaTap()
      {
         var i:int = 0;
         var bm:Bitmap = null;
         super();
         this._bg = ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":0,
            "y":7,
            "width":580,
            "height":289
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("29473",2),this,{
            "x":235,
            "y":222,
            "color":11515029
         });
         ComponentUtil.getBitmap("ZuoQi_BG",this,{
            "x":7,
            "y":17
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("ZuoQi_BG",this,{
            "x":350,
            "y":17
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("Text_WPK",this,{
            "x":269,
            "y":142
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("JianTou_2",this,{
            "x":230,
            "y":67
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("Text_QHCaiLiao",this,{
            "x":260,
            "y":118
         },Global.ZuoQi_c01_Imgsdm);
         this._leftHorse = new Child_tianTiUnit();
         this._rightHorse = new Child_tianTiUnit();
         this._leftHorse.type = this._rightHorse.type = Child_tianTiUnit.HORSE;
         this._leftHorse.x = 110;
         this._leftHorse.y = 185;
         this._rightHorse.x = 460;
         this._rightHorse.y = 185;
         this._leftHorse.jumpBindY = 195;
         this._leftHorse._way = this._rightHorse.way = 3;
         this._leftHorse.setFrameInterval(120);
         this._rightHorse.setFrameInterval(100);
         addChild(this._leftHorse);
         addChild(this._rightHorse);
         this._btnQiangHua = ComponentUtil.getButton("","Button_QiangHua",this,{
            "x":233,
            "y":241,
            "callBack":this.qiangHuaHd,
            "enabled":false
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":234,
            "y":206,
            "width":54,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":292,
            "y":206,
            "width":54,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Text_Back",[6,6,4,4],this,{
            "x":292,
            "y":224,
            "width":54,
            "height":16
         },Global.Img_Cdm);
         ComponentUtil.getTextField(LangConfig.getWord("29474",2),this,{
            "x":233,
            "y":188,
            "color":11515029
         });
         ComponentUtil.getTextField(LangConfig.getWord("29475",2),this,{
            "x":292,
            "y":188,
            "color":11515029
         });
         this._tfMaxLv = ComponentUtil.getTextField("",this,{
            "x":392,
            "size":14
         });
         this._tfNxtAtbMax = ComponentUtil.getTextField("",this,{
            "x":360,
            "y":237,
            "leading":4
         });
         this._tfMaxLv = ComponentUtil.getTextField(LangConfig.getWord("29492",2),this,{
            "visible":false,
            "x":360 + 50,
            "y":28 + 55,
            "color":10879157,
            "size":14,
            "bold":true
         });
         this._tfSucceed = ComponentUtil.getTextField("",this,{
            "x":258,
            "y":204,
            "color":16763955
         });
         this._tfLuck = ComponentUtil.getTextField("",this,{
            "x":319,
            "y":204,
            "realWidth":0,
            "color":3407667
         });
         this._tfLuck.autoSize = this._tfSucceed.autoSize = TextFieldAutoSize.CENTER;
         this._gridNeedsItem = new View_Grid();
         this._gridNeedsItem.set_bmp_over(true,null);
         this._gridNeedsItem.set_bmp_select(null);
         this._gridNeedsItem.x = 274;
         this._gridNeedsItem.y = 148;
         addChild(this._gridNeedsItem);
         this._tfItemNum = ComponentUtil.getTextField("",this,{
            "x":289,
            "y":166,
            "bold":true
         });
         this._tfItemNum.autoSize = TextFieldAutoSize.CENTER;
         this._tfCost = ComponentUtil.getTextField("",this,{
            "x":319,
            "y":222,
            "color":14671839,
            "realWidth":0
         });
         this._tfCost.autoSize = TextFieldAutoSize.CENTER;
         addChild(this._tfCost);
         var l1:VGroup = new VGroup(20,30,0,0,0,20);
         var l2:VGroup = new VGroup(364,30,0,0,0,20);
         i = 0;
         while(i < 10)
         {
            bm = new Bitmap();
            this._curStarArr.push(bm);
            l1.appendItem(bm);
            addChild(bm);
            bm = new Bitmap();
            this._nxtStarArr.push(bm);
            l2.appendItem(bm);
            addChild(bm);
            i += 1;
         }
         l1.align();
         l2.align();
         l1.dispose();
         l2.dispose();
      }
      
      public function updateQiangHuaInfo() : void
      {
         var curExtraAtbs:Array;
         var mulFun:Function;
         var curInfo:Array = null;
         var mul0:Number = NaN;
         var mulFun0:Function = null;
         var extraAtb:Object = null;
         var i:int = 0;
         var mul:Number = NaN;
         var nxtExtraAtbs:Array = null;
         var extraAtb2:Object = null;
         var j:int = 0;
         var vo:Vo_item = null;
         var has:int = 0;
         var cost:int = 0;
         var disCount:int = 0;
         mulFun0 = function(src:Number):int
         {
            return mul0 * src;
         };
         var lucky:int = Model_horse.qiangHuaLucky;
         var currentLv:int = Model_horse.qiangHuaStar;
         curInfo = Data_lib.zqqh[currentLv];
         var nxtInfo:Array = currentLv >= HorseConfig.MAXQIANGHUALV ? null : Data_lib.zqqh[currentLv + 1];
         mul0 = Number(curInfo[HorseConfig.QIANGHUA_MULTIPLE]);
         HorseConfig.clearTffs(this._tfCurAtbs);
         HorseConfig.clearTffs(this._tfNxtAtbs);
         this._tfCurAtbs = HorseConfig.getTffs(Data_lib.zqtj,Model_horse.qiangHuaHorseId.toString(),HorseConfig.LIB_BASE_ATB,"",mulFun0,"#ffffff","#ffffff","#ffffff");
         curExtraAtbs = HorseConfig.getTffs(Data_lib.zqqh,currentLv.toString(),HorseConfig.QIANGHUA_EXTRAATB,"",null,"#aaaa00","#aaaa00","#aaaa00");
         for each(extraAtb in curExtraAtbs)
         {
            this._tfCurAtbs.push(extraAtb);
         }
         i = 0;
         while(i < this._tfCurAtbs.length)
         {
            this._tfCurAtbs[i].x = 18 + 105 * int(i % 2);
            this._tfCurAtbs[i].y = 237 + 18 * int(i / 2);
            addChild(this._tfCurAtbs[i] as DisplayObject);
            i += 1;
         }
         if(Boolean(nxtInfo))
         {
            mulFun = function(src:Number):int
            {
               return mul * src;
            };
            mul = Number(nxtInfo[HorseConfig.QIANGHUA_MULTIPLE]);
            this._tfNxtAtbs = HorseConfig.getTffs(Data_lib.zqtj,Model_horse.qiangHuaHorseId.toString(),HorseConfig.LIB_BASE_ATB,"",mulFun,"#33ff33","#33ff33","#33ff33");
            nxtExtraAtbs = HorseConfig.getTffs(Data_lib.zqqh,(currentLv + 1).toString(),HorseConfig.QIANGHUA_EXTRAATB,"",null,"#ffff00","#ffff00","#ffff00");
            for each(extraAtb2 in nxtExtraAtbs)
            {
               this._tfNxtAtbs.push(extraAtb2);
            }
            j = 0;
            while(j < this._tfNxtAtbs.length)
            {
               this._tfNxtAtbs[j].x = 360 + 105 * int(j % 2);
               this._tfNxtAtbs[j].y = 237 + 18 * int(j / 2);
               addChild(this._tfNxtAtbs[j] as DisplayObject);
               j += 1;
            }
            this._tfSucceed.text = curInfo[HorseConfig.QIANGHUA_SUCCESS] + "%";
            this._tfLuck.text = lucky.toString() + "%";
            this._tfCost.text = curInfo[HorseConfig.QIANGHUA_SILVER_REQUIRE];
            vo = new Vo_item();
            vo.id = curInfo[HorseConfig.QIANGHUA_ITEMID_REQUIRE];
            vo.Init_lib();
            this._gridNeedsItem.vo = vo;
            this._gridNeedsItem.set_bmp_bg(null);
            this._btnQiangHua.enabled = true;
            this._tfNxtAtbMax.visible = false;
            has = CommandManager.get_bag_count(vo.id);
            cost = int(curInfo[HorseConfig.QIANGHUA_NUMITEM_REQUIRE]);
            this._tfItemNum.text = has.toString() + "/" + cost;
            disCount = 0;
            if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= curInfo[HorseConfig.QIANGHUA_SILVER_REQUIRE])
            {
               this._tfCost.color = 3407667;
            }
            else
            {
               this._tfCost.color = 16724787;
               disCount += 1;
            }
            if(has >= cost)
            {
               this._tfItemNum.color = 3407667;
               this._gridNeedsItem.set_grey(false);
            }
            else
            {
               this._tfItemNum.color = 16724787;
               this._gridNeedsItem.set_grey(true);
               disCount += 1;
            }
            this._btnQiangHua.enabled = true;
            this._rightHorse.visible = true;
            this._needSilver = curInfo[HorseConfig.QIANGHUA_SILVER_REQUIRE];
            this._needItemId = vo.id;
            this._needItemCount = cost;
            this._tfMaxLv.visible = false;
         }
         else
         {
            this._tfItemNum.color = 5592405;
            this._tfNxtAtbMax.visible = true;
            this._tfSucceed.htmlText = "--";
            this._tfLuck.htmlText = "--";
            this._tfCost.htmlText = "--";
            this._gridNeedsItem.vo = null;
            this._gridNeedsItem.set_bmp_bg(View_Grid.GRID_LOCK);
            this._btnQiangHua.enabled = false;
            this._tfItemNum.text = "";
            this._gridNeedsItem.set_grey(true);
            this._rightHorse.visible = false;
            this._tfMaxLv.visible = true;
         }
         this.updateStar();
      }
      
      public function updateStar() : void
      {
         var nxtLv:int = 0;
         var bm:Bitmap = null;
         var j:int = 0;
         var curLv:int = Model_horse.qiangHuaStar;
         nxtLv = curLv + 1;
         var i:int = this._curStarArr.length - 1;
         while(i >= 0)
         {
            Utils.getLoadBitmap(i < curLv ? Const_strImg.LV_INTENSIFY2 : Const_strImg.LV_INTENSIFY1,this._curStarArr[i] as Bitmap);
            i--;
         }
         if(nxtLv > 10)
         {
            for each(bm in this._nxtStarArr)
            {
               bm.visible = false;
            }
         }
         else
         {
            j = this._nxtStarArr.length - 1;
            while(j >= 0)
            {
               bm = this._nxtStarArr[j];
               bm.visible = bm.visible || true;
               Utils.getLoadBitmap(j < nxtLv ? Const_strImg.LV_INTENSIFY2 : Const_strImg.LV_INTENSIFY1,bm);
               j--;
            }
         }
      }
      
      private function handleBagUpdate() : void
      {
         var currentLv:int = Model_horse.qiangHuaStar;
         var pnl:View_horsePanel = Singleton.getInstance(View_horsePanel);
         if(currentLv != -1 && pnl.visible)
         {
            this.updateQiangHuaInfo();
         }
      }
      
      public function showEff(result:int) : void
      {
         var time:int = 0;
         this._effBm = this._effBm || new Bitmap();
         if(result == 1)
         {
            this._effBm.bitmapData = ComponentUtil.getBitmapData("instens",Global.wordEffect);
            addChild(this._effBm);
            EffectManager.addEffect("35063",this,1500,this.width / 2,70);
            time = 3000;
         }
         else
         {
            this._effBm.bitmapData = ComponentUtil.getBitmapData("insten_fail",Global.wordEffect);
            addChild(this._effBm);
            EffectManager.addEffect("35065",this,1000,this.width / 2,70);
            EffectManager.addEffect("35066",this,1000,this.width / 2,70);
            time = 2000;
         }
         if(this._effBm != null)
         {
            this._effBm.x = (this.width - this._effBm.width) / 2;
            this._effBm.y = 70 / 2;
            Tween.to(this._effBm,time,{"alpha":[1,0]},function():void
            {
               _effBm.bitmapData = null;
               removeChild(_effBm);
            });
         }
      }
      
      override public function get width() : Number
      {
         return this._bg.width;
      }
      
      override public function get height() : Number
      {
         return this._bg.height;
      }
      
      public function updateHorseLv() : void
      {
         var scale:Number = NaN;
         var k:int = Model_horse.qiangHuaHorseId;
         var horseId:int = int(Data_lib.zqtj[k][HorseConfig.LIB_MODELID]);
         if(k == 99512)
         {
            scale = 0.75;
         }
         else
         {
            scale = 1;
         }
         this._leftHorse.scaleX = this._leftHorse.scaleY = this._rightHorse.scaleX = this._rightHorse.scaleY = scale;
         this._leftHorse.modelId = this._rightHorse.modelId = horseId;
      }
      
      public function tapperShowMethod(info:Object) : Boolean
      {
         var _temp_1:* = this._leftHorse;
         this._rightHorse._way = 3;
         _temp_1._way = 3;
         HorseCGMessage.CG_HORSE_QIANGHUA_INFO();
         Global.control.registerCallBack(HorseConfig.HorsePanelFrame,this.onFrame);
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.handleBagUpdate);
         return true;
      }
      
      public function tapperHideMethod(info:Object) : Boolean
      {
         Global.control.removeCallBack(HorseConfig.HorsePanelFrame,this.onFrame);
         Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.handleBagUpdate);
         return true;
      }
      
      private function onFrame(i:int) : void
      {
         if(this._leftHorse.modelId != 0 && this._leftHorse.visible)
         {
            this._leftHorse.onFrame(i);
         }
         if(this._rightHorse.modelId != 0 && this._rightHorse.visible)
         {
            this._rightHorse.onFrame(i);
         }
      }
      
      private function qiangHuaHd(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(this._needItemId) < this._needItemCount)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29476",2));
            return;
         }
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < this._needSilver)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23437",2));
            return;
         }
         HorseCGMessage.CG_HORSE_QIANGHUA();
      }
   }
}

