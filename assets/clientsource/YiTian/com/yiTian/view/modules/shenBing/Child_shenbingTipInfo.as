package com.yiTian.view.modules.shenBing
{
   import com.utils.ColorConstant;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.HtmlUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mx.utils.StringUtil;
   
   public class Child_shenbingTipInfo extends Sprite
   {
      
      private var vo:Vo_ShenbingTipInfo;
      
      public function Child_shenbingTipInfo()
      {
         super();
         EffectManager.addEffect("35285",this,1000,0,0,true);
         this.addEventListener(MouseEvent.ROLL_OVER,this.onRoll);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
      }
      
      public function onRoll(evt:MouseEvent) : void
      {
         if(Boolean(this.vo))
         {
            TipManager.update(this.vo);
         }
      }
      
      public function onOut(evt:MouseEvent) : void
      {
         TipManager.hide();
      }
      
      public function updateTipInfo() : void
      {
         this.vo = new Vo_ShenbingTipInfo();
         this.vo.info = this.addTipsInfo();
      }
      
      private function addTipsInfo() : String
      {
         var position:String = null;
         var vo:Vo_ShenBingSkill = null;
         var addColor:Function = function(content:String, type:int):String
         {
            switch(type)
            {
               case 1:
                  return "<font size=\'11\'>" + content + "</font>";
               case 2:
                  return green(content);
               case 3:
                  return blue(content);
               case 4:
                  return purple(content);
               case 5:
                  return orange(content);
               default:
                  return "<font size=\'11\'>" + content + "</font>";
            }
         };
         var data:Array = Model_ShenBing._cardSlotSkills;
         var flag:Array = ["一：","二：","三：","四：","五：","六："];
         var quality:Array = ["白","绿","蓝","紫","橙"];
         var temp:Array = Data_lib.sbjc.toArray();
         var info:String = "";
         info += HtmlUtil.fontNoSize("<font size=\'11\'>神兵技能加成</font>\n",ColorConstant.getColorStr(ColorConstant.YELLOW));
         var i:int = 0;
         while(i < 6)
         {
            position = flag[i];
            vo = data[i];
            if(vo != null && vo.id != 0)
            {
               info += StringUtil.substitute("<font size=\'11\'>卡槽" + position + "{0}加成淬炼属性{1} {2}</font>\n",addColor(quality[vo.quality - 1] + "色品质技能",vo.quality),this.green(temp[vo.quality - 1][2] + "%"),this.getStatus(true));
            }
            else
            {
               info += "<font size=\'11\'>卡槽" + position + this.gay("白色品质加成淬炼属性 " + temp[0][2] + "%" + this.getStatus(false) + "</font>\n");
            }
            i++;
         }
         info += "<font size=\'11\'>注:白,</font>" + this.green("绿,") + this.blue("蓝,") + this.purple("紫,") + this.orange("橙,") + "<font size=\'11\'> 技能加成淬炼属性分别为:</font>" + this.green(temp[0][2] + "%") + "," + this.green(temp[1][2] + "%") + "," + this.green(temp[2][2] + "%") + "," + this.green(temp[3][2] + "%") + "," + this.green(temp[4][2] + "%");
         return info;
      }
      
      private function getStatus(state:Boolean) : String
      {
         return state ? this.green("（已激活）") : this.gay("（未激活）");
      }
      
      private function green(contetn:String) : String
      {
         return "<font color=\'#04ff00\' size=\'11\'>" + contetn + "</font>";
      }
      
      private function gay(contetn:String) : String
      {
         return "<font color=\'#999999\' size=\'11\'>" + contetn + "</font>";
      }
      
      private function blue(contetn:String) : String
      {
         return "<font color=\'#33CCFF\' size=\'11\'>" + contetn + "</font>";
      }
      
      private function purple(contetn:String) : String
      {
         return "<font color=\'#de45c7\' size=\'11\'>" + contetn + "</font>";
      }
      
      private function orange(contetn:String) : String
      {
         return "<font color=\'#ff7700\' size=\'11\'>" + contetn + "</font>";
      }
   }
}

