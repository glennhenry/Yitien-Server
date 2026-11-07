package com.yiTian.view.modules.chargeGuide
{
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class Vip_TYStop extends Panel
   {
      
      private static var isFirstOpen:Boolean = true;
      
      private static var isLoad:Boolean = false;
      
      private var btnArr:Array;
      
      private var btnVec:Vector.<Button> = new Vector.<Button>();
      
      private var bmp:Bitmap;
      
      private var moneyCostArr:Array = [68,288,1688];
      
      public function Vip_TYStop()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var btn:Button = null;
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":568,
            "height":360
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":520,
            "height":310
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_WXPrompt",this,{
            "x":204,
            "y":5
         },Global.Img_Cdm);
         move = new Rectangle(0,0,540,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":534,
            "y":5,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btnArr = [LangConfig.getWord("1099",0),LangConfig.getWord("1110",0),LangConfig.getWord("1111",0)];
         this.bmp = new Bitmap();
         this.bmp.x = 15;
         this.bmp.y = 45;
         addChild(this.bmp);
         this.bmp.visible = false;
         var i:int = 0;
         while(i < 3)
         {
            btn = ComponentUtil.getButton(this.btnArr[i],"Button_Bule",this,{
               "x":345,
               "y":225 + i * 35
            });
            btn.tabIndex = i;
            btn.addEventListener(MouseEvent.CLICK,this.cliHandle);
            this.btnVec.push(btn);
            i++;
         }
      }
      
      private function cliHandle(e:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < this.moneyCostArr[e.target.tabIndex])
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60098",6));
            UIManager.yuanBaoXiang.visible = true;
            return;
         }
         if(!UIManager.storeTip.visible)
         {
            UIManager.storeTip.visible = true;
         }
         switch(e.target.tabIndex)
         {
            case 0:
               UIManager.storeTip.update(46340,1,3,16000,68,9999,1,LangConfig.getWord("60103",6));
               break;
            case 1:
               UIManager.storeTip.update(46341,1,3,16000,288,9999,1,LangConfig.getWord("60104",6));
               break;
            case 2:
               UIManager.storeTip.update(46342,1,3,16000,1688,9999,1,LangConfig.getWord("60105",6));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               Utils.getLoadBitmap("resource/image/shouchong/VIP.jpg",this.bmp);
               SingleLoader.add("lang/ch/Guid_vip.swf",function(info:Object):void
               {
                  Global.Guid_vipdm = info.applicationDomain;
                  addBmp();
               });
            }
            else if(!isLoad)
            {
               this.addBmp();
            }
         }
      }
      
      private function addBmp() : void
      {
         var bmp:Bitmap = ComponentUtil.getBitmap("Guide_VIP",this,{
            "x":29,
            "y":45
         },Global.Guid_vipdm);
         setChildIndex(bmp,3);
         isLoad = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

