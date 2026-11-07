package com.yiTian.view.modules.horse
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.config.Action;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.HorseCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class Child_horseJinjieTap extends Sprite
   {
      
      private var _curModel:Child_tianTiUnit;
      
      private var _tfCurAtb:MyTextField;
      
      private var _nxtModel:Child_tianTiUnit;
      
      private var _tfNxtAtb:MyTextField;
      
      private var _btnJinjie:Button;
      
      private var _needGrid:View_Grid;
      
      private var _tfNeedSilver:MyTextField;
      
      private var _iremNumInfo:MyTextField;
      
      private var _runningModel:Array = [];
      
      private var _objMaxLv:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _curTffs:Array;
      
      private var _nxtTffs:Array;
      
      private var _needItemId:int;
      
      private var _needItemCount:int;
      
      private var _needSilver:int;
      
      public function Child_horseJinjieTap()
      {
         super();
         this._bg = ComponentUtil.getScaleBitmap("Back4",[3,3,1,1],this,{
            "x":0,
            "y":7,
            "width":580,
            "height":289
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("ZuoQi_BG",this,{
            "x":7,
            "y":17
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("ZuoQi_BG",this,{
            "x":350,
            "y":17
         },Global.ZuoQi_c01_Imgsdm);
         this._objMaxLv = ComponentUtil.getBitmap("Text_YJJDZGJ",this,{
            "x":389,
            "y":97
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("JianTou_1",this,{
            "x":230,
            "y":63
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("Text_SXCaiLiao",this,{
            "x":261,
            "y":146
         },Global.ZuoQi_c01_Imgsdm);
         ComponentUtil.getBitmap("Text_WPK",this,{
            "x":269,
            "y":170
         },Global.ZuoQi_c01_Imgsdm);
         this._curModel = new Child_tianTiUnit();
         this._nxtModel = new Child_tianTiUnit();
         this._curModel.type = this._nxtModel.type = Child_tianTiUnit.HORSE;
         this._curModel._way = this._nxtModel._way = 3;
         this._curModel._state = this._nxtModel._state = Action.RUN;
         this._curModel.x = 110;
         this._curModel.y = 185;
         this._nxtModel.x = 460;
         this._nxtModel.y = 185;
         this._curModel.zhuanShenStepTime = 100;
         this._curModel.jumpBindY = this._nxtModel.jumpBindY = 185;
         this._nxtModel.setFrameInterval(50);
         addChild(this._curModel);
         addChild(this._nxtModel);
         this._needGrid = new View_Grid();
         this._needGrid.set_bmp_select(null);
         this._needGrid.set_bmp_over(true,null);
         this._needGrid.x = 274;
         this._needGrid.y = 175;
         addChild(this._needGrid);
         this._iremNumInfo = ComponentUtil.getTextField("",this,{
            "x":289,
            "y":195,
            "bold":true
         },TextFieldAutoSize.CENTER);
         this._tfCurAtb = ComponentUtil.getTextField("",this,{
            "x":18,
            "y":237,
            "color":14671839,
            "leading":4
         });
         this._tfNxtAtb = ComponentUtil.getTextField("",this,{
            "x":360,
            "y":237,
            "color":14671839,
            "leading":4
         });
         this._tfNeedSilver = ComponentUtil.getTextField("",this,{
            "x":289,
            "y":220,
            "color":16710898,
            "size":12
         });
         this._tfNeedSilver.autoSize = TextFieldAutoSize.CENTER;
         this._tfNeedSilver.text = "";
         this._btnJinjie = ComponentUtil.getButton("","Button_JinJie",this,{
            "x":233,
            "y":241,
            "callBack":this.jinJieClickHd,
            "enabled":false
         },Global.ZuoQi_c01_Imgsdm);
      }
      
      public function updateInfos() : void
      {
         var info:Array = null;
         var j:int = 0;
         var vo:Vo_item = null;
         var numItemRequires:int = 0;
         var numItemHas:int = 0;
         var disCount:int = 0;
         var id:int = Model_horse.curJinJieId;
         this._runningModel.splice(0);
         info = Data_lib.zqtj[id];
         var nxtId:int = int(Data_lib.zqtj[id][HorseConfig.LIB_ELEVATING_ID]);
         var nxtInfo:Array = nxtId == HorseConfig.LIB_FINAL_TOKEN ? null : Data_lib.zqtj[nxtId];
         this._curModel.modelId = info[HorseConfig.LIB_MODELID];
         this._runningModel.push(this._curModel);
         HorseConfig.clearTffs(this._curTffs);
         HorseConfig.clearTffs(this._nxtTffs);
         this._curTffs = HorseConfig.getTffs(Data_lib.zqtj,id.toString(),HorseConfig.LIB_BASE_ATB,"",null,"#ffffff","#ffffff","#ffffff");
         var i:int = 0;
         while(i < this._curTffs.length)
         {
            this._curTffs[i].x = 18 + i % 2 * 100;
            this._curTffs[i].y = 237 + int(i / 2) * 18;
            addChild(this._curTffs[i] as DisplayObject);
            i += 1;
         }
         if(Boolean(nxtInfo))
         {
            this._nxtModel.modelId = nxtInfo[HorseConfig.LIB_MODELID];
            this._runningModel.push(this._nxtModel);
            this._nxtTffs = HorseConfig.getTffs(Data_lib.zqtj,nxtId.toString(),HorseConfig.LIB_BASE_ATB,"",null,"#33ff33","#33ff33","#33ff33");
            j = 0;
            while(j < this._curTffs.length)
            {
               this._nxtTffs[j].x = 360 + j % 2 * 100;
               this._nxtTffs[j].y = 237 + int(j / 2) * 18;
               addChild(this._nxtTffs[j] as DisplayObject);
               j += 1;
            }
            vo = new Vo_item();
            vo.id = info[HorseConfig.LIB_ELEVATE_ITEMID_REQUIRE];
            vo.Init_lib();
            numItemRequires = int(info[HorseConfig.LIB_ELEVATE_NUMITEM_REQUIRE]);
            numItemHas = CommandManager.get_bag_count(vo.id);
            this._iremNumInfo.htmlText = numItemHas.toString() + "/" + numItemRequires.toString();
            this._needGrid.vo = vo;
            this._objMaxLv.visible = false;
            this._nxtModel.visible = true;
            this._tfNeedSilver.text = LangConfig.getWord("29470",2,info[HorseConfig.LIB_ELEVATE_SILVER_REQUIRE]);
            this._needGrid.set_bmp_bg(null);
            disCount = 0;
            if(numItemHas >= numItemRequires)
            {
               this._iremNumInfo.color = 3407667;
               this._needGrid.set_grey(false);
            }
            else
            {
               this._needGrid.set_grey(true);
               this._iremNumInfo.color = 16724787;
               disCount += 1;
            }
            if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver >= info[HorseConfig.LIB_ELEVATE_SILVER_REQUIRE])
            {
               this._tfNeedSilver.color = 3407667;
            }
            else
            {
               this._tfNeedSilver.color = 16724787;
               disCount += 1;
            }
            this._btnJinjie.enabled = true;
            this._needItemId = vo.id;
            this._needItemCount = numItemRequires;
            this._needSilver = info[HorseConfig.LIB_ELEVATE_SILVER_REQUIRE];
         }
         else
         {
            this._tfNxtAtb.htmlText = "";
            this._needGrid.vo = null;
            this._objMaxLv.visible = true;
            this._nxtModel.visible = false;
            this._tfNeedSilver.htmlText = HtmlUtil.fontNoSize(LangConfig.getWord("29471",2),"#ff3333");
            this._needGrid.set_bmp_bg(View_Grid.GRID_LOCK);
            this._btnJinjie.enabled = false;
            this._iremNumInfo.text = "";
         }
         this._nxtModel.visible = nxtInfo != null;
      }
      
      public function showSuccess() : void
      {
         var bm:Bitmap = null;
         bm = ComponentUtil.getBitmap("Text_JJChengGong",this,null,Global.ZuoQi_c01_Imgsdm);
         bm.x = (this._bg.width - bm.width) / 2;
         bm.y = 35;
         EffectManager.addEffect("35063",this,1500,this._bg.width / 2,70);
         Tween.to(bm,3000,{"alpha":[2,0]},this.onBmComplete);
      }
      
      private function onBmComplete(bm:Bitmap) : void
      {
         bm.bitmapData = null;
         if(Boolean(bm.parent))
         {
            bm.parent.removeChild(bm);
         }
      }
      
      public function showUpdateAni() : void
      {
         var idx:int = 0;
         this._curModel.maimengDefault();
         idx = int(setTimeout(function():void
         {
            clearTimeout(idx);
            _nxtModel.maimengDefault();
         },1000));
      }
      
      private function handleBagUpdate() : void
      {
         var id:int = Model_horse.curJinJieId;
         var pnl:View_horsePanel = Singleton.getInstance(View_horsePanel);
         if(id != 0 && pnl.visible)
         {
            this.updateInfos();
         }
      }
      
      private function frameHd(i:int) : void
      {
         var m:Child_tianTiUnit = null;
         for each(m in this._runningModel)
         {
            if(m.modelId != 0 && m.visible)
            {
               m.onFrame(i);
            }
         }
      }
      
      public function tapperShowMethod(info:Object) : Boolean
      {
         HorseCGMessage.CG_HORSE_JINJIE_INFO();
         var _temp_1:* = this._curModel;
         this._nxtModel._way = 3;
         _temp_1._way = 3;
         Global.control.registerCallBack(HorseConfig.HorsePanelFrame,this.frameHd);
         Global.control.registerCallBack(Enum_MsgType.BAG_UPDATE,this.handleBagUpdate);
         return true;
      }
      
      public function tapperHideMethod(info:Object) : Boolean
      {
         Global.control.removeCallBack(HorseConfig.HorsePanelFrame,this.frameHd);
         Global.control.removeCallBack(Enum_MsgType.BAG_UPDATE,this.handleBagUpdate);
         return true;
      }
      
      private function jinJieClickHd(e:MouseEvent) : void
      {
         if(CommandManager.get_bag_count(this._needItemId) < this._needItemCount)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29472",2));
            return;
         }
         if(GameUnitManager.hero.silver + GameUnitManager.hero.bingSilver < this._needSilver)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("23437",2));
            return;
         }
         HorseCGMessage.CG_HORSE_JINJIE();
      }
   }
}

