package com.yiTian.view.modules.paobiao
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ColorConstant;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.gameUnit.role.Npc;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.PaoBiaoCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.NpcPanel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class YunSongBiaoChePanel extends NpcPanel
   {
      
      public static var vecPaoBiaoColor:Vector.<String> = new <String>[HtmlUtil.font("白色",ColorConstant.getColorStr(ColorConstant.WHITE)),HtmlUtil.font("绿色",ColorConstant.getColorStr(ColorConstant.GREEN)),HtmlUtil.font("蓝色",ColorConstant.getColorStr(ColorConstant.BLUE)),HtmlUtil.font("紫色",ColorConstant.getColorStr(ColorConstant.PURPLE))];
      
      private const NEEDSILVER:int = 20000;
      
      private var btnYunSong:Button;
      
      private var cbBaoXian:CheckBox;
      
      private var vecYS:Vector.<YunSongItem>;
      
      private var bmBack:Bitmap;
      
      private var curYS:YunSongItem;
      
      private const idArr:Array = [46252,46253,46254,46255];
      
      private var f:Boolean = true;
      
      public function YunSongBiaoChePanel()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":722,
            "height":455
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":674,
            "height":405
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":50,
            "width":654,
            "height":334
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,40);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":688,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bmBack = new Bitmap();
         this.bmBack.x = 35;
         this.bmBack.y = 51;
         addChild(this.bmBack);
         this.btnYunSong = ComponentUtil.getButton(LangConfig.getWord("10314",1),"Button_Orange",this,{
            "x":320,
            "y":400,
            "textColor":16184781
         },Global.Img_Cdm);
         this.cbBaoXian = new CheckBox("","CheckBox01",Global.Img_Cdm);
         this.cbBaoXian.x = 454;
         this.cbBaoXian.y = 394;
         var t:MyTextField = ComponentUtil.getTextField("",this,{
            "x":479,
            "y":394,
            "color":11904647,
            "size":12,
            "leading":0
         });
         t.multiline = true;
         t.htmlText = LangConfig.getWord("10315",1,this.NEEDSILVER);
         addChild(this.cbBaoXian);
         this.btnYunSong.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      protected function onClick(e:MouseEvent) : void
      {
         var id:int = 0;
         var baoXian:int = 0;
         var vec:Vector.<Vo_valuable> = null;
         if(Boolean(GameUnitManager.hero.paoBiao))
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("10316",1));
            return;
         }
         if(Boolean(this.curYS.index))
         {
            id = int(this.idArr[this.curYS.index - 1]);
            vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[id]);
            if(!vec.length)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10317",1));
               return;
            }
         }
         if(this.cbBaoXian.selected)
         {
            baoXian = 1;
            if(GameUnitManager.hero.silver < this.NEEDSILVER)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("10318",1));
               return;
            }
         }
         PaoBiaoCGMessage.CG_YUNSONG(id,baoXian);
         this.visible = false;
      }
      
      protected function YSClickHandler(e:MouseEvent) : void
      {
         var ys:YunSongItem = e.currentTarget as YunSongItem;
         if(this.curYS == ys)
         {
            return;
         }
         if(Boolean(this.curYS))
         {
            this.curYS.choose = false;
         }
         ys.choose = true;
         this.curYS = ys;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var i:int = 0;
         var ys:YunSongItem = null;
         var vec:Vector.<Vo_valuable> = null;
         super.visible = value;
         if(value)
         {
            if(!this.bmBack.bitmapData)
            {
               Utils.loadTitle("lang/ch/PaoBiao_Imgs.swf","Floor",this.bmBack,null,null);
            }
            if(this.f)
            {
               Utils.loadTitle("lang/ch/PaoBiao_Imgs.swf","Title_PaoBiao",new Bitmap(),{
                  "x":281,
                  "y":5
               },this);
               this.f = false;
            }
            i = 5;
            if(!this.vecYS)
            {
               this.vecYS = new Vector.<YunSongItem>(i,true);
            }
            while(Boolean(i--))
            {
               if(!this.vecYS[i])
               {
                  ys = new YunSongItem(i);
                  if(i < 3)
                  {
                     ys.x = 45 + (ys.width + 20) * i;
                     ys.y = 55;
                  }
                  else
                  {
                     ys.x = 172 + (ys.width + 20) * (i % 3);
                     ys.y = 215;
                  }
                  ys.index = i;
                  addChild(ys);
                  this.vecYS[i] = ys;
                  ys.addEventListener(MouseEvent.CLICK,this.YSClickHandler);
               }
               this.vecYS[i].update();
            }
            this.vecYS[0].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            i = 3;
            while(i >= 0)
            {
               vec = CommandManager.get_bag_vec(Enum_filter.ID,null,[this.idArr[i]]);
               if(Boolean(vec.length))
               {
                  this.vecYS[i + 1].dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                  break;
               }
               i--;
            }
         }
      }
      
      override public function show(npc:Npc) : void
      {
         super.show(npc);
         this.visible = true;
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

