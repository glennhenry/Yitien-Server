package com.yiTian.view.modules.kuafujingjichang
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.message.cg.KuaFuJingJiChangCGMessage;
   import com.yiTian.view.modules.tianTi.Child_tianTiUnit;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flashx.textLayout.formats.TextAlign;
   
   public class PingLunItem extends Sprite
   {
      
      private var LYbtn:Button;
      
      private var GZbtn:Button;
      
      private var GZnum:MyTextField;
      
      private var LYnum:MyTextField;
      
      private var PJnum:MyTextField;
      
      private var point:Bitmap;
      
      private var teamLvl:int;
      
      public var teamIndex:int;
      
      private var nameArr:Array;
      
      private var jobArr:Array;
      
      private var sexArr:Array;
      
      private var bodyArr:Array;
      
      private var wingArr:Array;
      
      private var weaponDirArr:Array;
      
      private var type:int;
      
      private var modelArr:Array = [];
      
      private var team:MyTextField;
      
      private var heroname:MyTextField;
      
      public function PingLunItem()
      {
         super();
         ComponentUtil.getBitmap("Back_PingLun",this,{
            "x":0,
            "y":0
         },Global.DRKF_Imgsdm);
         this.LYbtn = ComponentUtil.getButton("    冷遇","Button_LengYu",this,{
            "x":155,
            "y":10,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.GZbtn = ComponentUtil.getButton("关注    ","Button_GuanZhu",this,{
            "x":10,
            "y":10,
            "textColor":16184781
         },Global.DRKF_Imgsdm);
         this.LYbtn.addEventListener(MouseEvent.CLICK,this.LYClick);
         this.GZbtn.addEventListener(MouseEvent.CLICK,this.GZClick);
         ComponentUtil.getBitmap("Back_NumRight",this,{
            "x":112,
            "y":10
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Back_NumLeft",this,{
            "x":68,
            "y":10
         },Global.DRKF_Imgsdm);
         this.GZnum = ComponentUtil.getTextField("0",this,{
            "x":75,
            "y":9,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":30
         });
         this.GZnum.align = TextAlign.CENTER;
         this.LYnum = ComponentUtil.getTextField("0",this,{
            "x":115,
            "y":9,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":30
         });
         this.LYnum.align = TextAlign.CENTER;
         ComponentUtil.getBitmap("Back_Progress",this,{
            "x":5,
            "y":37
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Progress_Red",this,{
            "x":7,
            "y":39
         },Global.DRKF_Imgsdm);
         ComponentUtil.getBitmap("Progress_Green",this,{
            "x":7,
            "y":39
         },Global.DRKF_Imgsdm);
         this.point = ComponentUtil.getBitmap("Img_Point",this,{
            "x":106,
            "y":37
         },Global.DRKF_Imgsdm);
         ComponentUtil.getTextField("剩余关注和冷遇次数：",this,{
            "x":26,
            "y":52,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.PJnum = ComponentUtil.getTextField("",this,{
            "x":151,
            "y":52,
            "color":16776960,
            "size":12,
            "leading":0
         });
         this.team = ComponentUtil.getTextField("",this,{
            "x":55 - 50,
            "y":-260,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":200
         });
         this.team.align = TextAlign.CENTER;
         this.heroname = ComponentUtil.getTextField("",this,{
            "x":55,
            "y":-260,
            "color":16184781,
            "size":12,
            "leading":0,
            "realWidth":100
         });
         this.heroname.align = TextAlign.CENTER;
         Global.control.registerCallBack(Enum_MsgType.MSG_ENTERFRAME,this.onFrame);
      }
      
      public function LYClick(e:MouseEvent) : void
      {
         this.type = 2;
         KuaFuJingJiChangCGMessage.CG_SATR_PINGJIA(this.type,this.teamLvl,this.teamIndex);
      }
      
      public function GZClick(e:MouseEvent) : void
      {
         this.type = 1;
         KuaFuJingJiChangCGMessage.CG_SATR_PINGJIA(this.type,this.teamLvl,this.teamIndex);
      }
      
      public function remove() : void
      {
         if(DRKFRank.instance.isXuanZe)
         {
            DRKFRank.instance.isXuanZe = false;
            while(Boolean(this.modelArr.length))
            {
               removeChild(this.modelArr[0]);
               this.modelArr.shift();
               this.team.text = "";
               this.GZnum.visible = false;
               this.LYnum.visible = false;
               this.PJnum.visible = false;
            }
         }
      }
      
      public function updata(vo:PingLunVO) : void
      {
         var i:int = 0;
         var pointX:Number = NaN;
         this.teamLvl = vo.teamLvl;
         this.GZnum.text = vo.GZnum.toString();
         this.GZnum.visible = true;
         this.LYnum.text = vo.LYnum.toString();
         this.LYnum.visible = true;
         this.PJnum.text = (10 - vo.PJnum).toString() + "/10次";
         this.PJnum.visible = true;
         this.nameArr = vo._name.split("_");
         this.jobArr = vo._job.split("_");
         this.sexArr = vo._sex.split("_");
         this.weaponDirArr = vo._weaponDir.split("_");
         this.bodyArr = vo._body.split("_");
         this.wingArr = vo.wing.split("_");
         if(vo.GZnum == 0 && vo.LYnum == 0)
         {
            this.point.x = 106;
         }
         else
         {
            pointX = vo.GZnum / (vo.GZnum + vo.LYnum);
            this.point.x = 3 + pointX * 206;
         }
         if(DRKFRank.instance.isXuanZe)
         {
            DRKFRank.instance.isXuanZe = false;
            while(Boolean(this.modelArr.length))
            {
               removeChild(this.modelArr[0]);
               this.modelArr.shift();
               this.team.text = "";
            }
         }
         i = 0;
         for(; i < this.nameArr.length; addChild(this.modelArr[i]),addChild(this.heroname),addChild(this.team),i++)
         {
            if(!this.modelArr[i])
            {
               this.modelArr[i] = new Child_tianTiUnit();
               (this.modelArr[i] as Child_tianTiUnit).type = Child_tianTiUnit.PLAYER;
               (this.modelArr[i] as Child_tianTiUnit).way = 4;
               (this.modelArr[i] as Child_tianTiUnit).setFrameInterval(300);
               (this.modelArr[i] as Child_tianTiUnit).job = this.jobArr[i];
               (this.modelArr[i] as Child_tianTiUnit).sex = this.sexArr[i];
               (this.modelArr[i] as Child_tianTiUnit).name = Model_heFu.repNameUseSerID(this.nameArr[i]);
               (this.modelArr[i] as Child_tianTiUnit).modelId = this.bodyArr[i];
               (this.modelArr[i] as Child_tianTiUnit).weaponDir = this.weaponDirArr[i];
               (this.modelArr[i] as Child_tianTiUnit).wing = this.wingArr[i];
               (this.modelArr[i] as Child_tianTiUnit).updateLayer();
               (this.modelArr[i] as Child_tianTiUnit).addEventListener(MouseEvent.ROLL_OVER,this.over);
               (this.modelArr[i] as Child_tianTiUnit).addEventListener(MouseEvent.ROLL_OUT,this.out);
            }
            this.team.text = Model_heFu.repStr(vo._teamname);
            if(this.teamIndex == 1)
            {
               this.team.y = -280;
               this.team.x = 55 - 50;
               (this.modelArr[i] as Child_tianTiUnit).y = -125;
               switch(i)
               {
                  case 0:
                     (this.modelArr[i] as Child_tianTiUnit).x = 105 + 3;
                     break;
                  case 1:
                     (this.modelArr[i] as Child_tianTiUnit).x = 105 - 95;
                     break;
                  case 2:
                     (this.modelArr[i] as Child_tianTiUnit).x = 105 + 95;
               }
            }
            else
            {
               this.team.y = -200;
               (this.modelArr[i] as Child_tianTiUnit).scaleX = (this.modelArr[i] as Child_tianTiUnit).scaleY = 0.8;
               (this.modelArr[i] as Child_tianTiUnit).y = -75;
               if(this.teamIndex == 2)
               {
                  this.team.x = 75 - 50;
                  switch(i)
                  {
                     case 0:
                        (this.modelArr[i] as Child_tianTiUnit).x = 125;
                        break;
                     case 1:
                        (this.modelArr[i] as Child_tianTiUnit).x = 125 - 75;
                        break;
                     case 2:
                        (this.modelArr[i] as Child_tianTiUnit).x = 125 + 75;
                  }
               }
               else
               {
                  if(this.teamIndex != 3)
                  {
                     continue;
                  }
                  this.team.x = 55 - 50;
                  switch(i)
                  {
                     case 0:
                        (this.modelArr[i] as Child_tianTiUnit).x = 105;
                        break;
                     case 1:
                        (this.modelArr[i] as Child_tianTiUnit).x = 105 - 75;
                        break;
                     case 2:
                        (this.modelArr[i] as Child_tianTiUnit).x = 105 + 75;
                  }
               }
            }
         }
      }
      
      private function over(e:MouseEvent) : void
      {
         var n:String = null;
         n = Model_heFu.repsServName2((e.target as Child_tianTiUnit).name);
         this.heroname.y = this.team.y;
         this.heroname.x = (e.target as Child_tianTiUnit).x - 50;
         this.heroname.text = n;
         this.team.visible = false;
         this.heroname.visible = !this.team.visible;
      }
      
      private function out(e:MouseEvent) : void
      {
         this.team.visible = true;
         this.heroname.visible = !this.team.visible;
      }
      
      private function onFrame(interval:int) : void
      {
         var i:int = 0;
         while(i < this.modelArr.length)
         {
            (this.modelArr[i] as Child_tianTiUnit).onFrame(interval);
            i++;
         }
      }
   }
}

