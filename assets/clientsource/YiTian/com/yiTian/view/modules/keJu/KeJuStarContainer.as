package com.yiTian.view.modules.keJu
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.data.config.Enum_KeJu;
   import com.yiTian.data.model.Model_KeJu;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KejuCGMessage;
   import com.yiTian.view.modules.guaji.Child_processStar;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class KeJuStarContainer extends Sprite
   {
      
      public static const TYPE_1:String = LangConfig.getWord("80050",8);
      
      public static const TYPE_2:String = LangConfig.getWord("80051",8);
      
      private var countNum:int;
      
      private var nowNum:int;
      
      private var titleTF:MyTextField;
      
      private var typeStr:String;
      
      private var baseView:Sprite;
      
      private var starVec:Vector.<Sprite> = new Vector.<Sprite>();
      
      private var autoStar:Vector.<Child_processStar> = new Vector.<Child_processStar>();
      
      public function KeJuStarContainer()
      {
         super();
      }
      
      public function init(type:String, count:int) : void
      {
         this.nowNum = this.countNum = count;
         this.typeStr = type;
         this.createStar(this.countNum);
         this.titleTF = ComponentUtil.getTextField("",this,{
            "x":-3,
            "y":27,
            "textColor":16184781
         });
         this.titleTF.htmlText = "<font color=\'#FFFF00\'>" + type + "</font>" + LangConfig.getWord("80047",8) + this.nowNum + "/" + this.countNum;
         this.mouseEnabled = false;
      }
      
      private function createStar(num:int) : void
      {
         var star2:Child_processStar = null;
         var star:Effect = null;
         var rangY:int = 0;
         var sprite:Sprite = null;
         var i:int = 0;
         var str:String = null;
         this.baseView = new Sprite();
         addChild(this.baseView);
         this.baseView.mouseEnabled = false;
         rangY = 35;
         i = 0;
         while(i < num)
         {
            sprite = new Sprite();
            this.baseView.addChild(sprite);
            sprite.mouseEnabled = false;
            sprite.buttonMode = true;
            sprite.x = i * rangY;
            sprite.y = 8;
            this.starVec.push(sprite);
            str = this.typeStr == TYPE_1 ? "35122" : "35123";
            star = EffectManager.addEffect(str,sprite,1000,0,0,true);
            star.visible = false;
            star2 = new Child_processStar();
            star2.mouseEnabled = false;
            star2.filters = Util.disabled;
            star2.percent = 100;
            star2.y = -3;
            star2.x = i * rangY - 12;
            star2.visible = false;
            addChild(star2);
            this.autoStar.push(star2);
            sprite.addEventListener(MouseEvent.CLICK,this.chooseHandler);
            if(this.typeStr == TYPE_2)
            {
               TipManager.bind(sprite,LangConfig.getWord("80024",8,Enum_KeJu.MONEYTIP[i]));
            }
            i++;
         }
      }
      
      private function chooseHandler(event:MouseEvent) : void
      {
         if(this.typeStr == TYPE_1)
         {
            if(this.nowNum <= 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80025",8));
               return;
            }
            if(Model_KeJu.isLucky == 1)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80026",8));
               View_Keju.instance.caishenStar.dispose(false);
            }
            else
            {
               KejuCGMessage.CG_USE_LUCKY();
               Model_KeJu.isLucky = 1;
               this.dispose(false);
               View_KejuBroadcast.instance.addMsg(LangConfig.getWord("80052",8));
            }
         }
         else if(this.typeStr == TYPE_2)
         {
            if(this.nowNum <= 0)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("80027",8));
               return;
            }
            KejuCGMessage.CG_USE_CAISHEN(Model_KeJu.questID,Model_KeJu.answernum,Model_KeJu.isLucky,1,View_Keju.instance.getWriteTime());
            event.target.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
         }
      }
      
      public function updata(num:int) : void
      {
         var star:Sprite = null;
         var star2:Child_processStar = null;
         this.nowNum = num;
         var i:int = 0;
         while(i < this.countNum)
         {
            star = this.starVec[i];
            star2 = this.autoStar[i];
            if(i < num)
            {
               star.filters = [];
               star.mouseEnabled = true;
               star2.percent = 100;
            }
            else if(i >= num)
            {
               star.filters = Util.disabled;
               star.mouseEnabled = false;
               star2.percent = 0;
            }
            i++;
         }
         this.titleTF.htmlText = "<font color=\'#FFFF00\'>" + this.typeStr + "</font>" + LangConfig.getWord("80047",8) + this.nowNum + "/" + this.countNum;
      }
      
      public function dispose(enabled:Boolean) : void
      {
         var star:Sprite = null;
         var star2:Child_processStar = null;
         this.baseView.mouseChildren = enabled;
         if(enabled)
         {
            this.baseView.filters = [];
         }
         else
         {
            this.baseView.filters = Util.disabled;
         }
         var i:int = 0;
         while(i < this.countNum)
         {
            star = this.starVec[i];
            star2 = this.autoStar[i];
            if(enabled && i >= this.nowNum)
            {
               star.visible = false;
               star2.visible = true;
            }
            else
            {
               star.visible = enabled;
               star2.visible = !enabled;
            }
            i++;
         }
      }
   }
}

