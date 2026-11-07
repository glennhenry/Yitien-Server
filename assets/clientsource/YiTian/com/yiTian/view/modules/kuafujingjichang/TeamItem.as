package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.net.message.cg.PetCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TeamItem extends Sprite
   {
      
      public var tsBtn:Button;
      
      public var zhanli:Bitmap;
      
      public var zhanlitf:MyTextField;
      
      public var Name:MyTextField;
      
      public var zhiye:MyTextField;
      
      public var level:MyTextField;
      
      public var jifen:MyTextField;
      
      public var nametf:MyTextField;
      
      public var zhiyetf:MyTextField;
      
      public var leveltf:MyTextField;
      
      public var jifentf:MyTextField;
      
      public var touxiang:Bitmap;
      
      public var grid:View_Grid;
      
      public var player:Bitmap;
      
      public var id:Number = 0;
      
      public var heroid:Number = 0;
      
      public function TeamItem()
      {
         super();
         ComponentUtil.getBitmap("Back_RoleInf",this,{
            "x":0,
            "y":0 + 330
         },Global.DRKF_Imgsdm);
         this.tsBtn = ComponentUtil.getButton("踢出","Button_TS",this,{
            "x":50,
            "y":208 + 100,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Back_ZhanLi",this,{
            "x":10,
            "y":98
         },Global.DRKF_Imgsdm);
         this.zhanlitf = ComponentUtil.getTextField("00000",this,{
            "x":80,
            "y":108,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.nametf = ComponentUtil.getTextField("角色中文名称",this,{
            "x":47,
            "y":13 + 330,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.zhiyetf = ComponentUtil.getTextField("角色职业",this,{
            "x":47,
            "y":36 + 330,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.leveltf = ComponentUtil.getTextField("000级",this,{
            "x":47,
            "y":59 + 330,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this.jifentf = ComponentUtil.getTextField("00000",this,{
            "x":47,
            "y":82 + 330,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_bmp_bg();
         this.grid.set_bmp_select();
         this.grid.set_bmp_over();
         this.grid.x = 128 - 19;
         this.grid.y = 291.5 - 224 + 330;
         this.grid.isAutoLoad = false;
         addChild(this.grid);
         this.touxiang = new Bitmap();
         this.touxiang.scaleX = this.touxiang.scaleY = 0.85;
         this.grid.addChild(this.touxiang);
         this.player = ComponentUtil.getBitmap("",this,{
            "x":10,
            "y":30 + 100
         },Global.Img_Cdm);
         this.player.scaleX = this.player.scaleY = 0;
         this.tsBtn.addEventListener(MouseEvent.CLICK,this.tsClick);
         this.grid.addEventListener(MouseEvent.CLICK,this.gridClick);
      }
      
      public function setBtnParent() : void
      {
         var py:Number = NaN;
         var px:Number = x + this.tsBtn.x;
         py = y + this.tsBtn.y;
         parent.addChild(this.tsBtn);
         this.tsBtn.x = px;
         this.tsBtn.y = py;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(!value)
         {
            this.tsBtn.visible = false;
         }
      }
      
      private function gridClick(e:MouseEvent) : void
      {
         if(Boolean(this.id))
         {
            PetCGMessage.CG_PET_OTHER_INFO(this.id);
            (this.parent.parent as TeamPanel).petInfoVisible(true);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("没有宠物");
         }
      }
      
      private function tsClick(e:MouseEvent) : void
      {
         if(Boolean(TeamPanel.instance._bmc2))
         {
            if(TeamPanel.instance._bmc2.visible)
            {
               UIManager.centerBroadcast.addMsg("寻找队伍中不能踢出队伍");
               return;
            }
         }
         if(!TeamPanel.instance._bmc || TeamPanel.instance._bmc.visible == false)
         {
            KuaFuJingJiChangCGMessage.CG_TEAM_TS(this.heroid);
         }
         else
         {
            UIManager.centerBroadcast.addMsg("撮合中不能踢出队伍");
         }
      }
   }
}

