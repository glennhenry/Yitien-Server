package com.yiTian.view.modules.tuanGou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_bag;
   import com.yiTian.data.vo.Vo_TuanGouItem;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.role.Hero;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TuanGouCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TuanGouItem extends Sprite
   {
      
      private var grid:View_Grid;
      
      private var txt:MyTextField;
      
      private var back:Shape;
      
      private var button:Button;
      
      private var id:int;
      
      private var yuanJia:int;
      
      private var xianJia:int;
      
      private var yiShou:int;
      
      private var str_Name:String = LangConfig.getWord("60321",6);
      
      private var _Vo:Vo_TuanGouItem;
      
      private var yuanJiaT:MyTextField;
      
      private var xianJiaT:MyTextField;
      
      private var yiShouT:MyTextField;
      
      private var vo:Vo_item;
      
      private var errorStr:String;
      
      public function TuanGouItem(_vo:Vo_TuanGouItem)
      {
         super();
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":235,
            "height":105
         },Global.Img_Cdm);
         this._Vo = _vo;
         this.grid = new View_Grid(true);
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_tf_count();
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.x = 5;
         this.grid.y = 5;
         this.vo = new Vo_item();
         this.vo.id = this._Vo.itemId;
         this.vo.Init_lib();
         this.grid.vo = this.vo;
         this.grid.set_bmp_select();
         TipManager.unBind(this.grid);
         addChild(this.grid);
         this.yuanJia = this._Vo.yuanJia;
         this.xianJia = this._Vo.xianJia;
         this.yiShou = this._Vo.yiShou;
         this.str_Name = this.vo.str_name + LangConfig.getWord("60322",6) + this._Vo.xianGou + LangConfig.getWord("60323",6);
         this.txt = ComponentUtil.getTextField(this.str_Name,this,{
            "x":80,
            "y":8,
            "color":3644132,
            "size":12,
            "leading":0
         });
         this.yuanJiaT = ComponentUtil.getTextField(LangConfig.getWord("60291",6),this,{
            "x":90,
            "y":30,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.xianJiaT = ComponentUtil.getTextField(LangConfig.getWord("60292",6),this,{
            "x":90,
            "y":48,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.yiShouT = ComponentUtil.getTextField(LangConfig.getWord("60324",6),this,{
            "x":5,
            "y":76,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.button = ComponentUtil.getButton(LangConfig.getWord("60094",6),"Button_store",this,{
            "x":128,
            "y":70,
            "textColor":16184781
         },Global.Img_Cdm);
         this.button.callBack = this.buy;
         this.button.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.button.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.drawLine();
      }
      
      public function update(_vo:Vo_TuanGouItem) : void
      {
         this._Vo = _vo;
         this.vo.id = this._Vo.itemId;
         this.vo.str_name = this._Vo.name;
         this.vo.Init_lib();
         this.grid.vo = this.vo;
         this.yuanJia = this._Vo.yuanJia;
         this.xianJia = this._Vo.xianJia;
         this.yiShou = this._Vo.yiShou;
         if(this._Vo.xianGou != 0)
         {
            this.str_Name = this.vo.str_name + LangConfig.getWord("50086",5,this._Vo.xianGou);
         }
         else
         {
            this.str_Name = this.vo.str_name;
         }
         this.txt.htmlText = this.str_Name;
         if(this._Vo.itemId != 46507)
         {
            this.changelTxt();
         }
         else
         {
            this.liJuanTxt();
         }
      }
      
      public function changelTxt() : void
      {
         this.yuanJiaT.htmlText = LangConfig.getWord("60326",6) + this.yuanJia.toString() + LangConfig.getWord("60235",6);
         this.xianJiaT.htmlText = LangConfig.getWord("60327",6) + this.xianJia.toString() + LangConfig.getWord("60235",6);
         this.yiShouT.htmlText = LangConfig.getWord("60325",6) + this.yiShou.toString() + LangConfig.getWord("60328",6);
         this.errorStr = LangConfig.getWord("50087",5);
      }
      
      public function liJuanTxt() : void
      {
         this.yuanJiaT.htmlText = LangConfig.getWord("60326",6) + this.yuanJia.toString() + LangConfig.getWord("60237",6);
         this.xianJiaT.htmlText = LangConfig.getWord("60327",6) + this.xianJia.toString() + LangConfig.getWord("60237",6);
         this.yiShouT.htmlText = LangConfig.getWord("60325",6) + this.yiShou.toString() + LangConfig.getWord("60328",6);
         this.errorStr = LangConfig.getWord("50088",5);
      }
      
      private function drawLine() : void
      {
         var shape:Shape = new Shape();
         shape.graphics.clear();
         shape.graphics.lineStyle(2,16777215);
         shape.graphics.moveTo(this.yuanJiaT.x,this.yuanJiaT.y + 8);
         shape.graphics.lineTo(this.yuanJiaT.x + this.yuanJiaT.width * 2,this.yuanJiaT.y + 8);
         addChild(shape);
      }
      
      protected function onOut(e:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      protected function onOver(e:MouseEvent) : void
      {
         var str:String = LangConfig.getWord("60329",6) + this._Vo.takeCount.toString() + LangConfig.getWord("60328",6);
         TipManager.update(str);
      }
      
      private function buy(e:MouseEvent) : void
      {
         var showStr:String = null;
         if(Model_bag.pwdLockState == Model_bag.PWD_STATE_LOCK_T)
         {
            UIManager.bagPwdPutIn.visible = true;
            return;
         }
         var hero:Hero = GameUnitManager.hero;
         if(hero.level < 35)
         {
            showStr = LangConfig.getWord("60333",6);
            UIManager.centerBroadcast.addMsg(showStr);
            return;
         }
         if(this._Vo.itemId != 46507)
         {
            if(hero.money < this._Vo.xianJia)
            {
               showStr = LangConfig.getWord("50089",5,this.errorStr);
               UIManager.centerBroadcast.addMsg(showStr);
               return;
            }
         }
         else if(hero.liquan < this._Vo.xianJia)
         {
            showStr = LangConfig.getWord("50089",5,this.errorStr);
            UIManager.centerBroadcast.addMsg(showStr);
            return;
         }
         TuanGouCGMessage.CG_TUANGOU_TAKE_GOODS(this._Vo.itemId);
      }
   }
}

