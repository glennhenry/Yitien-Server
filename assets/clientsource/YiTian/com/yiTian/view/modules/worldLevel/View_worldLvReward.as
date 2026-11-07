package com.yiTian.view.modules.worldLevel
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_worldLevel;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class View_worldLvReward extends Panel
   {
      
      private var instance9:MyTextField;
      
      private var instance10:MyTextField;
      
      private var instance5:WorldLvRewItem;
      
      private var instance6:WorldLvRewItem;
      
      private var instance4:WorldLvRewItem;
      
      private var instance3:WorldLvRewItem;
      
      private var inviteWanFaContainer:Sprite;
      
      private var wItems:Vector.<WorldLvRewItem>;
      
      public function View_worldLvReward()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var worldLvRewItem:WorldLvRewItem = null;
         move = new Rectangle(0,0,388,36);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":388,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":39,
            "width":340,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":80,
            "width":320,
            "height":130
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Icons_Prompt",this,{
            "x":34,
            "y":50
         },Global.Img_Cdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":354,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var titleBm:Bitmap = new Bitmap();
         Utils.loadTitle("lang/ch/SJDengJi_Imgs.swf","Title_SJFuLi",titleBm,{
            "x":114,
            "y":5
         },this);
         this.instance9 = ComponentUtil.getTextField(LangConfig.getWord("60355",6),this,{
            "x":62,
            "y":53,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.inviteWanFaContainer = new Sprite();
         addChild(this.inviteWanFaContainer);
         this.instance10 = ComponentUtil.getTextField(LangConfig.getWord("60356",6),this.inviteWanFaContainer,{
            "x":295,
            "y":53,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.instance10.underline = true;
         this.wItems = new Vector.<WorldLvRewItem>();
         var i:int = 0;
         while(i < 4)
         {
            worldLvRewItem = new WorldLvRewItem(i);
            worldLvRewItem.x = 50 + i * 75;
            worldLvRewItem.y = 95;
            addChild(worldLvRewItem);
            this.wItems.push(worldLvRewItem);
            i++;
         }
      }
      
      public function update(data:Array) : void
      {
         var len:int = int(this.wItems.length);
         var i:int = 0;
         while(i < len)
         {
            this.wItems[i].data = data[i];
            i++;
         }
      }
      
      public function updateWorldLvBind() : void
      {
         TipManager.bind(this.inviteWanFaContainer,LangConfig.getWord("50069",5,Model_worldLevel.worldLev));
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

