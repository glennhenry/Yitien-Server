package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.containers.list.IListItem;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.net.handler.DRKFHandler;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class DRKFItem extends IListItem
   {
      
      public static var teamid:int;
      
      public static var teamtype:int;
      
      public var back:Bitmap;
      
      public var room:MyTextField;
      
      public var Name:MyTextField;
      
      public var num:MyTextField;
      
      private var heartBitmap:Bitmap;
      
      public var lock:Bitmap;
      
      private var vo:TeamVo;
      
      public function DRKFItem()
      {
         super();
         this.init();
      }
      
      private function init() : void
      {
         this.back = ComponentUtil.getBitmap("Img_Room",this,{
            "x":0,
            "y":0
         },Global.DRKF_Imgsdm);
         this.room = ComponentUtil.getTextField("NO.000",this,{
            "x":12,
            "y":7,
            "color":13887132,
            "size":16,
            "leading":0
         });
         this.room.align = TextAlign.CENTER;
         this.Name = ComponentUtil.getTextField("队长：玩家中文名字",this,{
            "x":12,
            "y":28,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this.Name.align = TextAlign.CENTER;
         this.num = ComponentUtil.getTextField("0/0",this,{
            "x":74,
            "y":151,
            "color":16774912,
            "size":16,
            "leading":0
         });
         this.num.align = TextAlign.CENTER;
         addEventListener(MouseEvent.CLICK,this.joinFun);
         this.mouseChildren = true;
         this.buttonMode = true;
      }
      
      override public function dispose() : void
      {
         this.vo = null;
      }
      
      override public function set data(value:Object) : void
      {
         this.show(value as TeamVo);
      }
      
      public function show(vo:TeamVo) : void
      {
         this.vo = vo;
         this.room.text = "NO." + vo.team_id + "  " + vo.team_name;
         this.Name.htmlText = "<a href=\'event:role_" + vo.captain_id + "\'>" + vo.captain_name + "</a>";
         this.num.text = vo.team_num + "/3";
         if(Boolean(vo.password))
         {
            this.lock = ComponentUtil.getBitmap("Locked",this,{
               "x":136,
               "y":60
            },Global.DRKF_Imgsdm);
         }
         else
         {
            this.lock = ComponentUtil.getBitmap("UnLock",this,{
               "x":136,
               "y":60
            },Global.DRKF_Imgsdm);
         }
      }
      
      private function joinFun(event:MouseEvent) : void
      {
         var password:String = this.vo.password.toString();
         teamid = this.vo.team_id;
         teamtype = this.vo.team_type;
         if(this.vo.password == 0)
         {
            password = "";
            DRKFHandler.joinDRKFTeam(this.vo.team_id,this.vo.team_type,password);
            Util.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
         }
         else
         {
            Global.delegate.dosomething(passwordPanel.instance,passwordPanel.instance.show);
         }
      }
   }
}

