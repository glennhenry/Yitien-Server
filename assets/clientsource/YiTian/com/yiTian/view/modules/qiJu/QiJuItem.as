package com.yiTian.view.modules.qiJu
{
   import com.ui.containers.list.IListItem;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.handler.QiJuHandler;
   import com.yiTian.utils.Utils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   
   public class QiJuItem extends IListItem
   {
      
      private var vo:TeamVo;
      
      private const TYPE_ARR:Array = [LangConfig.getWord("80147",8),null,LangConfig.getWord("80146",8),LangConfig.getWord("80148",8)];
      
      private var heartBitmap:Bitmap;
      
      private var button:Button;
      
      private var nameTF:MyTextField;
      
      private var levelTF:MyTextField;
      
      private var typeTF:MyTextField;
      
      private var numTF:MyTextField;
      
      private var tipTF:MyTextField;
      
      public function QiJuItem()
      {
         super();
         this.init();
      }
      
      override public function dispose() : void
      {
         this.vo = null;
      }
      
      override public function set data(value:Object) : void
      {
         this.show(value as TeamVo);
      }
      
      private function show(vo:TeamVo) : void
      {
         this.vo = vo;
         Utils.getLoadBitmap(QiJuHandler.getHeatUrl(vo.captain_sex,vo.captain_job),this.heartBitmap);
         this.nameTF.htmlText = "<u><a href=\'event:role_" + vo.captain_id + "\'>" + vo.captain_name + "</a></u>";
         this.levelTF.text = Enum_QiJu.type_level[vo.team_type];
         this.typeTF.text = Enum_QiJu.qiju_type[vo.team_type];
         this.numTF.text = vo.team_num + "/3";
         this.upBtn(vo.status);
      }
      
      private function upBtn(type:int) : void
      {
         if(type == 1)
         {
            this.button.visible = true;
            this.tipTF.visible = false;
         }
         else
         {
            this.tipTF.visible = true;
            this.button.visible = false;
            this.tipTF.text = this.TYPE_ARR[type];
         }
      }
      
      private function init() : void
      {
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":0,
            "y":30,
            "width":335,
            "height":2
         },Global.Img_Cdm);
         this.nameTF = ComponentUtil.getTextField("",this,{
            "x":27,
            "y":7,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.levelTF = ComponentUtil.getTextField("",this,{
            "x":123,
            "y":7,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.typeTF = ComponentUtil.getTextField("",this,{
            "x":175,
            "y":7,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.numTF = ComponentUtil.getTextField("",this,{
            "x":239,
            "y":7,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this.nameTF.mouseEnabled = true;
         this.nameTF.addEventListener(TextEvent.LINK,QiJuHandler.linkHandler);
         this.heartBitmap = new Bitmap();
         addChild(this.heartBitmap);
         ComponentUtil.setPropertie(this.heartBitmap,{
            "x":8,
            "y":8
         });
         this.button = ComponentUtil.getButton(LangConfig.getWord("80149",8),"Button_Two",this,{
            "x":286,
            "y":2,
            "textColor":16773818
         },Global.Img_Cdm);
         this.button.callBack = this.joinFun;
         this.tipTF = ComponentUtil.getTextField("",this,{
            "x":270,
            "y":7,
            "realWidth":70,
            "color":16724736
         });
         this.tipTF.align = "center";
         this.mouseChildren = true;
         this.mouseEnabled = false;
         this.buttonMode = false;
      }
      
      private function joinFun(event:MouseEvent) : void
      {
         trace(this.vo.team_id);
         QiJuHandler.joinQijuTeam(this.vo.team_id,this.vo.team_type);
         Util.stage.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
      }
   }
}

