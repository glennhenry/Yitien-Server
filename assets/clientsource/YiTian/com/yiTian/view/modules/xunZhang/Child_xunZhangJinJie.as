package com.yiTian.view.modules.xunZhang
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.model.Model_role;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   
   public class Child_xunZhangJinJie extends Sprite
   {
      
      public static const strArr:Array = ["对玩家抵抗爆伤:","对玩家伤害加成:","对玩家伤害减免:"];
      
      public static const TypeArr:Array = ["气血","攻击","防御"];
      
      private var grid:View_Grid;
      
      private var tfVec:Vector.<MyTextField> = new Vector.<MyTextField>();
      
      private var typeTf:MyTextField;
      
      private var type:int;
      
      private var tfManJi:MyTextField;
      
      public function Child_xunZhangJinJie()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_Red",[22,22,1,90],this,{
            "x":0,
            "y":0,
            "width":206,
            "height":419
         },Global.XunZhangdm);
         ComponentUtil.getScaleBitmap("Back_SZT",[94,25,1,36],this,{
            "x":11,
            "y":48,
            "width":184,
            "height":228
         },Global.XunZhangdm);
         ComponentUtil.getBitmap("BG_CaiNiao",this,{
            "x":0,
            "y":0
         },Global.XunZhangdm);
         ComponentUtil.getScaleBitmap("Back_ShuJu",[13,13,1,90],this,{
            "x":2,
            "y":286,
            "width":201,
            "height":131
         },Global.XunZhangdm);
         ComponentUtil.getBitmap("BG_Quan",this,{
            "x":32,
            "y":100
         },Global.XunZhangdm);
         var i:int = 0;
         while(i < 3)
         {
            this.tfVec.push(ComponentUtil.getTextField("",this,{
               "x":73,
               "y":316 + 20 * i,
               "color":14013822,
               "size":14,
               "leading":12
            }));
            i++;
         }
         this.grid = new View_Grid(true);
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,null);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.bmpBacKShow = false;
         addChild(this.grid);
         ComponentUtil.setPropertie(this.grid,{
            "x":68.6,
            "y":119
         });
         this.typeTf = ComponentUtil.getTextField("菜鸟勋章",this,{
            "x":71,
            "y":8,
            "color":4110903,
            "size":16,
            "leading":0
         });
      }
      
      public function initTye(_type:int) : void
      {
         this.type = _type;
      }
      
      public function update() : void
      {
         var i:int = 0;
         var ___ss:String = null;
         var ___arr:Array = null;
         var _dataArr:Array = null;
         var _a:Array = null;
         var __ss:String = null;
         var __arr:Array = null;
         var __dataArr:Array = null;
         var __a:Array = null;
         this.reset();
         var _vo:Vo_equip = Model_role.xunZhangVo as Vo_equip;
         if(!_vo)
         {
            return;
         }
         var bsJC:int = _vo.baoShangJC;
         var kB:int = _vo.kangBao;
         var bsJM:int = _vo.baoShangJM;
         var _data:Array = [kB,bsJC,bsJM];
         var vo:Vo_equip = new Vo_equip();
         if(_vo.id < 99145)
         {
            vo.id = _vo.id + this.type;
            vo.baoShangJC = bsJC;
            vo.baoShangJM = bsJM;
            vo.kangBao = kB;
            vo.Init_lib();
            this.grid.vo = vo;
            if(Boolean(this.tfManJi))
            {
               this.tfManJi.visible = false;
            }
            this.typeTf.htmlText = this.grid.vo.str_name;
            ___ss = Data_lib.equip[vo.id][6];
            ___arr = ___ss.split(",");
            _dataArr = [];
            i = 0;
            while(i < ___arr.length)
            {
               _a = ___arr[i].split("_");
               _dataArr.push(_a[1]);
               i++;
            }
            i = 0;
            while(i < _data.length)
            {
               this.tfVec[i].htmlText = TypeArr[i] + "+" + _dataArr[i] + "\n";
               i++;
            }
         }
         else
         {
            vo.id = _vo.id;
            vo.baoShangJC = bsJC;
            vo.baoShangJM = bsJM;
            vo.kangBao = kB;
            vo.Init_lib();
            this.grid.vo = vo;
            if(!this.tfManJi)
            {
               this.tfManJi = ComponentUtil.getTextField("",this,{
                  "x":this.grid.x + 10,
                  "y":this.grid.y + 23
               });
            }
            this.tfManJi.visible = true;
            if(this.type == 1)
            {
               this.grid.visible = false;
               this.tfManJi.htmlText = HtmlUtil.font("已满级","#fe0000");
               this.typeTf.htmlText = HtmlUtil.font("已满级","#fe0000",16);
               this.tfVec[1].htmlText = HtmlUtil.font(HtmlUtil.bold("已  满  级"),"#fe0000",18);
               this.tfVec[1].x = 65;
            }
            else
            {
               this.typeTf.htmlText = this.grid.vo.str_name;
               __ss = Data_lib.equip[_vo.id][6];
               __arr = __ss.split(",");
               __dataArr = [];
               i = 0;
               while(i < __arr.length)
               {
                  __a = __arr[i].split("_");
                  __dataArr.push(__a[1]);
                  i++;
               }
               i = 0;
               while(i < __dataArr.length)
               {
                  this.tfVec[i].htmlText = TypeArr[i] + "+" + __dataArr[i] + "\n";
                  i++;
               }
            }
         }
      }
      
      private function reset() : void
      {
         var i:int = 0;
         while(i < this.tfVec.length)
         {
            this.tfVec[i].text = "";
            this.tfVec[i].x = 73;
            i++;
         }
         if(Boolean(this.tfManJi))
         {
            this.tfManJi.visible = false;
         }
         this.grid.visible = true;
         this.typeTf.text = "";
      }
   }
}

