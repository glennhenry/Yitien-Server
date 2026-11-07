package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.gameUnit.config.Status;
   import com.yiTian.gameUnit.role.Role;
   import com.yiTian.utils.Tween;
   
   public class View_AiDeBaoBao_staticNPC extends Role
   {
      
      private var body:int;
      
      private var npcName:String;
      
      private var dialogue:String;
      
      private var direction:int;
      
      private var position:Array;
      
      private var txt:MyTextField;
      
      private var backShape:ScaleBitmap;
      
      private var _content:String;
      
      public function View_AiDeBaoBao_staticNPC(body:int, npcName:String, dialogue:String, direction:int, position:Array)
      {
         super();
         this.body = body;
         this.npcName = npcName;
         this.dialogue = dialogue;
         this.direction = direction;
         this.position = position;
         this.Init();
      }
      
      private function Init() : void
      {
         global_x = this.position[0];
         global_y = this.position[1];
         this.setBody(Status.NOMAL,this.body);
         this.setShadow(Status.NOMAL,56900);
         this.way = this.direction;
         ComponentUtil.getTextField(this.npcName,this,{
            "x":0,
            "y":-130
         },"center");
         this.txt = ComponentUtil.getTextField(this.dialogue,this,{
            "x":0,
            "y":-150,
            "color":16776960
         },"center");
         this.backShape = ComponentUtil.getScaleBitmap("Chat_board",[3,3,32,14],this,{
            "x":0,
            "y":-150,
            "width":this.txt.width + 20,
            "height":20
         },Global.Img_Cdm);
         addChild(this.backShape);
         addChild(this.txt);
         this.setTxt(this.dialogue,3000);
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      public function setTxt(content:String, costTime:int, twn:Object = null) : void
      {
         twn ||= Tween.BEE_LINE;
         this._content = content;
         this.txt.text = "";
         Tween.to(this,costTime,{"txtPercent":[0,1.5]},function():void
         {
            setTxt(content,costTime);
         },null,twn);
      }
      
      public function set txtPercent(p:Number) : void
      {
         this.txt.text = this._content.slice(0,this._content.length * p);
         this.backShape.width = this.txt.width + 20;
         this.backShape.x = -this.backShape.width / 2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Tween.stop(this);
      }
   }
}

