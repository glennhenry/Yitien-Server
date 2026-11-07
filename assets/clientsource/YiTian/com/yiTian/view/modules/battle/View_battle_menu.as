package com.yiTian.view.modules.battle
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.vo.Vo_Skill;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_battle_menu extends Sprite
   {
      
      private var bg:Bitmap;
      
      private var hpBm:Bitmap;
      
      private var mpBm:Bitmap;
      
      private var angryIcon:Bitmap;
      
      private var angryPro:Bitmap;
      
      private var hpContainer:Sprite;
      
      private var mpContainer:Sprite;
      
      private var angryContainer:Sprite;
      
      private var hpMask:Shape;
      
      private var mpMask:Shape;
      
      private var angryMask:Shape;
      
      private var angryTf:MyTextField;
      
      private var grids:Array = [];
      
      private var _hp:int;
      
      private var _hpMax:int;
      
      private var _mp:int;
      
      private var _mpMax:int;
      
      private var _angry:int;
      
      private var isOnHpBar:Boolean;
      
      private var isOnMpBar:Boolean;
      
      public function View_battle_menu()
      {
         super();
         ComponentUtil.getBitmap("ProgressBack_Fight",this,{
            "x":64,
            "y":5
         },Global.Scenedm);
         this.hpContainer = new Sprite();
         addChild(this.hpContainer);
         this.hpBm = ComponentUtil.getBitmap("Progress_FightHP",this,{
            "x":64,
            "y":5
         },Global.Scenedm);
         this.hpMask = ComponentUtil.getShape(42,76,0,0);
         this.hpMask.x = 64;
         this.hpMask.y = 5;
         this.hpContainer.addChild(this.hpMask);
         this.hpBm.mask = this.hpMask;
         this.mpContainer = new Sprite();
         addChild(this.mpContainer);
         this.mpBm = ComponentUtil.getBitmap("Progress_FightMP",this,{
            "x":99,
            "y":5
         },Global.Scenedm);
         this.mpMask = ComponentUtil.getShape(42,76,0,0);
         this.mpMask.x = 99;
         this.mpMask.y = 5;
         this.mpContainer.addChild(this.mpMask);
         this.mpBm.mask = this.mpMask;
         this.bg = ComponentUtil.getBitmap("Back_Fight",this,{
            "x":0,
            "y":0
         },Global.Scenedm);
         this.angryIcon = ComponentUtil.getBitmap("PowerFull",this,{
            "x":140,
            "y":9
         },Global.battleDm);
         this.angryContainer = new Sprite();
         addChild(this.angryContainer);
         this.angryPro = ComponentUtil.getBitmap("Power_Progress",this,{
            "x":175,
            "y":33
         },Global.Scenedm);
         this.angryMask = ComponentUtil.getShape(192,6,0,0);
         this.angryMask.x = 175;
         this.angryMask.y = 33;
         this.angryContainer.addChild(this.angryMask);
         this.angryPro.mask = this.angryMask;
         this.initGrid();
         this.angryTf = ComponentUtil.getTextField("",this,{
            "x":110 + 160,
            "y":25
         },TextFieldAutoSize.CENTER);
         this.hpContainer.addEventListener(MouseEvent.ROLL_OVER,this.setOnHpBar);
         this.hpContainer.addEventListener(MouseEvent.ROLL_OUT,this.setOnHpBar);
         this.mpContainer.addEventListener(MouseEvent.ROLL_OVER,this.setOnMpBar);
         this.mpContainer.addEventListener(MouseEvent.ROLL_OUT,this.setOnMpBar);
      }
      
      private function setOnHpBar(e:MouseEvent) : void
      {
         this.isOnHpBar = e.type == MouseEvent.ROLL_OVER;
      }
      
      private function setOnMpBar(e:MouseEvent) : void
      {
         this.isOnMpBar = e.type == MouseEvent.ROLL_OVER;
      }
      
      private function initGrid() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < 6)
         {
            grid = new View_Grid();
            grid.type = Enum_type_grid.BATTLE;
            grid.set_bmp_bg(View_Grid.GRID_MAINMENU);
            grid.set_bmp_over(true,null);
            grid.set_tf_info((i + 1).toString());
            grid.index = i;
            grid.x = 146 + i * 38;
            grid.y = 44;
            addChild(grid);
            this.grids.push(grid);
            i++;
         }
      }
      
      public function initSkill() : void
      {
         var len:int = int(Vo_Skill.barData.length);
         var i:int = 0;
         while(i < len)
         {
            (this.grids[i] as View_Grid).vo = Vo_Skill.getDataById(Vo_Skill.barData[i]);
            i++;
         }
      }
      
      public function updateGrid() : void
      {
      }
      
      public function updateInfo(hp:int, maxHp:int, mp:int, maxMp:int, angry:int) : void
      {
         this.updateHp(hp,maxHp);
         this.updateMp(mp,maxMp);
         this.updateAngry(angry);
      }
      
      private function updateHp(hp:int, maxHp:int) : void
      {
         if(this._hp == hp && this._hpMax == maxHp)
         {
            return;
         }
         this._hp = hp;
         this._hpMax = maxHp;
         var tarHei:int = 76 * hp / maxHp;
         var tarY:int = 5 + 76 - tarHei;
         Tween.to(this.hpMask,60,{
            "height":[this.hpMask.height,tarHei],
            "y":[this.hpMask.y,tarY]
         });
         TipManager.bind(this.hpContainer,Data_lib.attribute[3][0] + "：" + hp + "/" + maxHp);
         if(this.isOnHpBar)
         {
            this.hpContainer.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
         }
      }
      
      private function updateMp(mp:int, maxMp:int) : void
      {
         if(this._mp == mp && this._mpMax == maxMp)
         {
            return;
         }
         this._mp = mp;
         this._mpMax = maxMp;
         var tarHei:int = 76 * mp / maxMp;
         var tarY:int = 5 + 76 - tarHei;
         Tween.to(this.mpMask,60,{
            "height":[this.mpMask.height,tarHei],
            "y":[this.mpMask.y,tarY]
         });
         TipManager.bind(this.mpContainer,Data_lib.attribute[5][0] + "：" + mp + "/" + maxMp);
         if(this.isOnMpBar)
         {
            this.mpContainer.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
         }
      }
      
      private function updateAngry(angry:int) : void
      {
         if(this._angry == angry)
         {
            return;
         }
         this._angry = angry;
         var tarWid:int = 192 * angry / 100;
         Tween.to(this.angryMask,60,{"width":[this.angryMask.width,tarWid]});
         this.angryIcon.visible = angry == 100;
         this.angryTf.text = angry + "/100";
      }
   }
}

