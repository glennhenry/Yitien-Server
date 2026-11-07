package com.yiTian.view.modules.touzijijin
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.net.message.cg.TouZiJiJinCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GridItemView extends Sprite
   {
      
      private var _gridVec:Vector.<View_Grid>;
      
      private var _awardBtn:Button;
      
      private var buyNumTF:MyTextField;
      
      private var biliTF:MyTextField;
      
      private var index:int;
      
      private var _effArr:Vector.<Effect> = new Vector.<Effect>();
      
      public function GridItemView()
      {
         var grid:View_Grid = null;
         super();
         this._gridVec = new Vector.<View_Grid>(7);
         ComponentUtil.getScaleBitmap("Back_LBD",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":732,
            "height":48
         },Global.TZJJ_Imgsdm);
         var i:int = 0;
         while(i < this._gridVec.length)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,true,true);
            ComponentUtil.setPropertie(grid,{
               "x":345 + 40 * i,
               "y":5
            });
            addChild(grid);
            this._gridVec[i] = grid;
            grid.visible = false;
            i++;
         }
         this.buyNumTF = ComponentUtil.getTextField("",this,{
            "x":91,
            "y":14,
            "color":16776960,
            "size":14,
            "leading":0,
            "bold":true
         });
         this.biliTF = ComponentUtil.getTextField("",this,{
            "x":264,
            "y":16,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this._awardBtn = ComponentUtil.getButton("返利期领取","Button_TwoBule91",this,{
            "x":637,
            "y":11,
            "textColor":16771436
         },Global.Img_Cdm);
         this._awardBtn.callBack = this.getAward;
      }
      
      public function initData(dataArr:Array, btnIndex:int) : void
      {
         var _grid:View_Grid = null;
         var _type:int = 0;
         var _id:int = 0;
         var _count:int = 0;
         var _isAddEff:int = 0;
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         this.buyNumTF.text = "累计购买" + dataArr[1] + "封";
         this.biliTF.text = dataArr[4] + "%";
         var effArr:Array = [];
         var singleArr:Array = dataArr[2].split(",");
         var len:int = int(singleArr.length);
         var tempArr:Array = [];
         var i:int = 0;
         while(i < len)
         {
            tempArr = singleArr[i].split("_");
            _grid = this._gridVec[i];
            _type = int(tempArr[0]);
            _id = int(tempArr[1]);
            _count = int(tempArr[2]);
            _isAddEff = int(tempArr[3]);
            effArr.push(_isAddEff);
            if(_type == 1)
            {
               _voI = new Vo_item();
               _voI.id = _id;
               _voI.count = _count;
               _voI.Init_lib();
               _grid.vo = _voI;
            }
            else if(_type == 2)
            {
               _voE = new Vo_equip();
               _voE.id = _id;
               _voE.count = _count;
               _voE.Init_lib();
               _grid.vo = _voE;
            }
            _grid.visible = true;
            i++;
         }
         this.index = btnIndex;
         this.addEff(effArr);
         if(btnIndex == 4)
         {
            this.biliTF.x = 253;
            this.biliTF.y = 13;
            this.biliTF.size = 16;
         }
      }
      
      private function getAward(event:MouseEvent = null) : void
      {
         var tip:String = "<font color =\'#ffffff\'>确定领取该投资返利奖励吗？</font><br/><font color=\'#ff0000\'>注:所有奖励只能领取其中一份</font>";
         View_Alert.show(tip,View_Alert.OK_CANCAL,function():void
         {
            TouZiJiJinCGMessage.CG_TouZiJiJin_GETAWARD();
            View_TZJJPanel.btnIndex = index;
         });
      }
      
      public function flyIcon() : void
      {
         var grid:View_Grid = null;
         var i:int = 0;
         while(i < this._gridVec.length)
         {
            grid = this._gridVec[i];
            ComboTweenStep.toBag(grid);
            i++;
         }
      }
      
      public function setEnable(status:int) : void
      {
         if(status == 1)
         {
            this._awardBtn.enabled = true;
            this._awardBtn.label = "领取";
         }
         else if(status == 2)
         {
            this._awardBtn.enabled = false;
            this._awardBtn.label = "已领取";
         }
         else
         {
            this._awardBtn.enabled = false;
         }
      }
      
      public function addEff(arr:Array) : void
      {
         var effect:Effect = null;
         var grid:View_Grid = null;
         var i:int = 0;
         if(Boolean(this._gridVec.length))
         {
            i = this._gridVec.length - 1;
            while(i >= 0)
            {
               if(arr[i] == 1)
               {
                  grid = this._gridVec[i] as View_Grid;
                  effect = EffectManager.addEffect("35176",grid,1200,17,18,true);
                  this._effArr.push(effect);
               }
               i--;
            }
         }
      }
   }
}

