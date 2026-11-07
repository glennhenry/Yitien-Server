package com.yiTian.view.modules.zhuanZhi
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.modules.specialBtnDill.Model_specialD;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_zhuanZhiFangXiang extends Panel123
   {
      
      private var items:Array = [];
      
      private var itemTweenCount:int;
      
      private var curFoucusItem:Item;
      
      private var sPropertys:Array = [{
         "scaleX":0.85,
         "scaleY":0.85,
         "x":-123
      },{
         "scaleX":0.85,
         "scaleY":0.85,
         "x":123
      }];
      
      private var bPropertys:Array = [{
         "scaleX":1,
         "scaleY":1,
         "x":-103
      },{
         "scaleX":1,
         "scaleY":1,
         "x":103
      }];
      
      public function View_zhuanZhiFangXiang()
      {
         super();
         regResource("lang/ch/ZhuanZhi_Imgs.swf","ZhuanZhi_Imgsdm");
      }
      
      override protected function initUI2() : void
      {
         var i:int = 0;
         var it:Item = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":-235,
            "y":-251,
            "width":470,
            "height":502
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":-211,
            "y":-211,
            "width":422,
            "height":452
         },Global.Img_Cdm);
         move = new Rectangle(-235,-251,width,38);
         ComponentUtil.getTextField(LangConfig.getWord("29425",2),this,{
            "x":-201,
            "y":217,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField(LangConfig.getWord("29426",2),this,{
            "x":-199,
            "y":-201,
            "color":14662240,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":201,
            "y":-245,
            "callBack":this.btnCloseClickHd
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_JinJie",this,{
            "x":-80,
            "y":-246
         },Global.ZhuanZhi_Imgsdm);
         var arr:Array = [["Back_Zheng","Button_Zheng","Zheng_ShuXing","Icon_ShuXing","Zheng_JingMai","Icon_JingMai"],["Back_Xie","Button_Xie","Xie_ShuXing","Icon_ShuXing","Xie_JingMai","Icon_JingMai"]];
         i = 0;
         while(i < arr.length)
         {
            it = new Item(arr[i][0],arr[i][1],arr[i][2],arr[i][3],arr[i][4],arr[i][5]);
            addChild(it);
            it.x = i * 206 + 132 - 235;
            it.y = 263 - 251;
            it.cgIndex = i + 1;
            it.addEventListener(MouseEvent.ROLL_OVER,this.itClickHd);
            this.items.push(it);
            i += 1;
         }
         var infos:Array = ZhuanZhiUtil.getJobGridVos();
         var z:int = int(Enum_job.getChildJobZ(Enum_job.getBaseJob(GameUnitManager.hero.job)));
         var x:int = int(Enum_job.getChildJobX(Enum_job.getBaseJob(GameUnitManager.hero.job)));
         this.items[0].setVos(infos[0]);
         this.items[0].setJob(z);
         this.items[0].setMerTip(ZhuanZhiUtil.getMeriAdd(z));
         this.items[1].setVos(infos[1]);
         this.items[1].setJob(x);
         this.items[1].setMerTip(ZhuanZhiUtil.getMeriAdd(x));
      }
      
      private function itClickHd(evt:MouseEvent) : void
      {
         var idx:int = this.items.indexOf(evt.target);
         this.setChoose(idx);
      }
      
      private function setChoose(idx:uint) : void
      {
         var property:Object = null;
         if(Boolean(idx == -1) || Boolean(this.itemTweenCount) || this.items[idx] == this.curFoucusItem)
         {
            return;
         }
         this.curFoucusItem = this.items[idx] as Item;
         var i:int = 0;
         while(i < this.items.length)
         {
            property = this.items[i] == this.items[idx] ? this.bPropertys[idx] : this.sPropertys[i];
            this.items[i].setGridsEnabed(this.items[i] == this.items[idx]);
            Tween.curTo(this.items[i],400,property,null,null,Tween.EASYINOUT);
            i += 1;
         }
      }
      
      private function onItemTweenComplete() : void
      {
         this.itemTweenCount -= 1;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth / 2;
         y = Global.stage.stageHeight / 2;
      }
      
      private function btnCloseClickHd(e:MouseEvent) : void
      {
         this.visible = false;
      }
      
      public function show() : void
      {
         this.visible = true;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var roleJobWay:int = 0;
         if(value)
         {
            roleJobWay = int(Enum_job.getChildWay(GameUnitManager.hero.job));
            if(roleJobWay != 0)
            {
               this.setChoose(roleJobWay - 1);
            }
            super.visible = value;
         }
         else
         {
            Model_specialD.visFalseComp(this,ZhuanZhiUtil.zhuanZhiTipBtn,this.superHide);
         }
      }
      
      private function superHide() : void
      {
         super.visible = false;
      }
   }
}

import Layout.GridGroup;
import Layout.ILayout;
import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Enum_type_grid;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.vo.Vo_Skill;
import com.yiTian.manager.GameUnitManager;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.TipManager;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.ZhuanZhiCGMessage;
import com.yiTian.utils.Pool;
import com.yiTian.view.comp.View_Alert;
import com.yiTian.view.comp.View_Grid;
import com.yiTian.view.modules.zhuanZhi.JobAttProxy;
import flash.display.Sprite;
import flash.events.MouseEvent;

class Item extends Sprite
{
   
   private var tf_decript:MyTextField;
   
   private var grids:Array = [];
   
   private var btn:Button;
   
   private var _cgIndex:int;
   
   private var _gi:ILayout;
   
   private var _attSP:Sprite;
   
   private var _jmSp:Sprite;
   
   private var _this:Object;
   
   private var _attProxy:JobAttProxy;
   
   public function Item(bgStyle:String, buttonStyle:String, shuXingStyle:String, shuXingIcon:String, jingMaiStyle:String, jingMaiIcon:String)
   {
      super();
      this._this = this;
      ComponentUtil.getBitmap(bgStyle,this,{
         "x":-98,
         "y":-189
      },Global.ZhuanZhi_Imgsdm);
      this._attSP = new Sprite();
      ComponentUtil.getBitmap(shuXingStyle,this._attSP,{
         "x":-89,
         "y":-72
      },Global.ZhuanZhi_Imgsdm);
      ComponentUtil.getBitmap(shuXingIcon,this._attSP,{
         "x":-72,
         "y":-72
      },Global.ZhuanZhi_Imgsdm);
      addChild(this._attSP);
      this._attProxy = new JobAttProxy(this._attSP);
      this._attProxy.addEvent();
      this._jmSp = new Sprite();
      ComponentUtil.getBitmap(jingMaiStyle,this._jmSp,{
         "x":-89,
         "y":-28
      },Global.ZhuanZhi_Imgsdm);
      ComponentUtil.getBitmap(jingMaiIcon,this._jmSp,{
         "x":-72,
         "y":-28
      },Global.ZhuanZhi_Imgsdm);
      addChild(this._jmSp);
      this.btn = ComponentUtil.getButton("",buttonStyle,this,{
         "x":-62,
         "y":174,
         "callBack":this.btnClickHd
      },Global.ZhuanZhi_Imgsdm);
      this._gi = new GridGroup(-80,42,0,0,0,42,0,42,4);
   }
   
   public function setCGIdex(v:int) : void
   {
      this._cgIndex = v;
   }
   
   public function setJob(jobIndex:int) : void
   {
      this._attProxy.setJob(jobIndex);
   }
   
   public function getCGIdex() : int
   {
      return this._cgIndex;
   }
   
   public function setGridsEnabed(v:Boolean) : void
   {
      var g:View_Grid = null;
      for each(g in this.grids)
      {
         g.set_grey(!v);
      }
   }
   
   public function setMerTip(v:String) : void
   {
      TipManager.bind(this._jmSp,v);
   }
   
   public function setVos(arr:Array) : void
   {
      var grid:View_Grid = null;
      var obj:Object = null;
      var ngrid:View_Grid = null;
      for each(grid in this.grids)
      {
         removeChild(grid);
      }
      this.grids.splice(0);
      this._gi.clearItem();
      for each(obj in arr)
      {
         if(obj is Vo_Skill)
         {
            ngrid = Pool.getObject(View_Grid);
            ngrid.set_bmp_bg();
            ngrid.set_bmp_over(true,null);
            ngrid.type = Enum_type_grid.STATIC_SKILL;
            addChild(ngrid);
            ngrid.vo = obj as Vo_Skill;
            this.grids.push(ngrid);
            this._gi.appendItem(ngrid);
         }
      }
      this._gi.align();
   }
   
   private function btnClickHd(e:MouseEvent) : void
   {
      var myWay:int = int(Enum_job.getChildWay(GameUnitManager.hero.job));
      if(myWay == 0)
      {
         View_Alert.show(LangConfig.getWord("29427",2,this._cgIndex == 1 ? LangConfig.getWord("29430",2) : LangConfig.getWord("29431",2)),View_Alert.OK_CANCAL,function():void
         {
            ZhuanZhiCGMessage.CG_ZZ_CHOICE_WAY(_cgIndex);
         });
         return;
      }
      if(myWay == this._cgIndex)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("29428",2));
         return;
      }
      View_Alert.show(LangConfig.getWord("29429",2,1000),View_Alert.OK_CANCAL,function():void
      {
         ZhuanZhiCGMessage.CG_ZZ_CHOICE_WAY(_cgIndex);
      });
   }
   
   public function set scaleZNum(v:Number) : void
   {
      var p1:Number = v % 2;
   }
   
   public function set btnLabel(v:String) : void
   {
      this.btn.label = v;
   }
   
   public function set cgIndex(v:int) : void
   {
      this._cgIndex = v;
   }
}
