package com.yiTian.view.modules.tip.tips
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_job;
   import com.yiTian.gameUnit.role.BattleUnit;
   import com.yiTian.manager.LangConfig;
   
   public class View_BattleUnitTip extends View_tip
   {
      
      private var _battleUnit:BattleUnit;
      
      private var _nameTF:MyTextField;
      
      private var _infoTF:MyTextField;
      
      private var _hpBar:MyTextField;
      
      private var _angryBar:MyTextField;
      
      private var arr:Array = new Array();
      
      public function View_BattleUnitTip()
      {
         super();
      }
      
      override public function Init() : void
      {
         this.initStr();
         addBorder();
         this._nameTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":5,
            "color":327424,
            "size":16,
            "bold":true
         });
         this._infoTF = ComponentUtil.getTextField("",this,{
            "x":5,
            "y":30,
            "color":16043313,
            "realWidth":130,
            "wordWrap":true,
            "leading":7
         });
         this._hpBar = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":30,
            "color":16043313
         });
         this._angryBar = ComponentUtil.getTextField("",this,{
            "x":50,
            "y":52,
            "color":16043313
         });
      }
      
      private function initStr() : void
      {
         this.arr = [LangConfig.getWord("769",0),LangConfig.getWord("770",0),LangConfig.getWord("771",0),LangConfig.getWord("772",0),LangConfig.getWord("773",0)];
      }
      
      override public function Show(vo:Object, type:int = 1, stoneLvl:int = 0) : void
      {
         var tmp:Number = NaN;
         visible = true;
         if(this._battleUnit == vo && !this._battleUnit.isUpdate)
         {
            return;
         }
         this._battleUnit = vo as BattleUnit;
         this._battleUnit.isUpdate = false;
         this._nameTF.htmlText = this._battleUnit.name + "  " + this._battleUnit.level + LangConfig.getWord("774",0);
         this._infoTF.text = LangConfig.getWord("775",0) + "\n" + LangConfig.getWord("776",0) + "\n" + LangConfig.getWord("777",0) + this.arr[Enum_job.getBaseJob(this._battleUnit.job)];
         this._hpBar.text = this._battleUnit.hp + "/" + this._battleUnit.hpMax;
         this._angryBar.text = this._battleUnit.angry + "/" + this._battleUnit.angryMax;
         x = Global.stage.mouseX + 10;
         y = Global.stage.mouseY + 5;
         tmp = Math.max(this._infoTF.x + this._infoTF.width,this._nameTF.x + this._nameTF.width,this._hpBar.x + this._hpBar.width,this._angryBar.x + this._angryBar.width);
         border.width = tmp + 4;
         border.height = this._infoTF.y + this._infoTF.textHeight + 10;
      }
   }
}

