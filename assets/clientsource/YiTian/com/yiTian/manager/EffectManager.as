package com.yiTian.manager
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.utils.Util;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_thing_type;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class EffectManager
   {
      
      private static var effects:Vector.<Effect> = new Vector.<Effect>();
      
      public function EffectManager()
      {
         super();
      }
      
      public static function run(now:int) : void
      {
         var effect:Effect = null;
         var past:int = 0;
         var i:int = effects.length - 1;
         while(i >= 0)
         {
            effect = effects[i] as Effect;
            past = now - effect.beginTime;
            if(past >= effect.totalTime)
            {
               if(!effect.isLoop)
               {
                  effects.splice(i,1);
                  if(Boolean(effect.parent))
                  {
                     effect.parent.removeChild(effect);
                  }
                  if(effect.endCallBack != null)
                  {
                     effect.endCallBack();
                  }
                  effect.dispose();
               }
               else
               {
                  effect.beginTime = now;
               }
            }
            else
            {
               effect.update(now - effect.beginTime,effect.totalTime);
            }
            i--;
         }
      }
      
      public static function addEffect(sourceId:String, parent:Sprite, totalTime:int, px:int, py:int, isLoop:Boolean = false, loadLevel:int = 3, endCallBack:Function = null) : Effect
      {
         var eff:Effect = Effect.getEffect();
         eff.init(sourceId,loadLevel);
         eff.endCallBack = endCallBack;
         eff.totalTime = totalTime;
         eff.px = px;
         eff.py = py;
         eff.isLoop = isLoop;
         if(Boolean(parent))
         {
            parent.addChild(eff);
         }
         effects.push(eff);
         return eff;
      }
      
      public static function removeEffect(eff:Effect) : void
      {
         if(!eff)
         {
            return;
         }
         eff.transform.colorTransform = Util.colorNomal;
         var index:int = effects.indexOf(eff);
         if(index != -1)
         {
            effects.splice(index,1);
            if(Boolean(eff.parent))
            {
               eff.parent.removeChild(eff);
            }
            eff.dispose();
         }
      }
      
      public static function flyEff(fromPoint:Point, toPoint:Point) : void
      {
         var eff:Effect = Effect.getEffect();
         eff.init("35040");
         eff.totalTime = 23 * 50;
         eff.px = fromPoint.x;
         eff.py = fromPoint.y;
         eff.isLoop = false;
         GameScene.upUILayer.addChild(eff);
         effects.push(eff);
         setTimeout(fly,7 * 50,eff,fromPoint,toPoint);
      }
      
      public static function flyHuangbangEff(fromPoint:Point, toPoint:Point) : void
      {
         var eff:Effect = Effect.getEffect();
         eff.init("35217");
         eff.totalTime = 28 * 50;
         eff.px = fromPoint.x;
         eff.py = fromPoint.y;
         eff.isLoop = false;
         GameScene.upUILayer.addChild(eff);
         effects.push(eff);
         setTimeout(flyHuangbang,5 * 50,eff,fromPoint,new Point(Global.stage.stageWidth - 200,50));
         setTimeout(flyHuangbangend,15 * 50,eff,new Point(Global.stage.stageWidth - 200,50),toPoint);
      }
      
      private static function flyHuangbang(eff:Effect, fromPoint:Point, toPoint:Point) : void
      {
         Tween.to(eff,10 * 50,{
            "px":[fromPoint.x,toPoint.x],
            "py":[fromPoint.y,toPoint.y]
         });
      }
      
      private static function flyHuangbangend(eff:Effect, fromPoint:Point, toPoint:Point) : void
      {
         Tween.to(eff,13 * 50,{
            "px":[fromPoint.x,toPoint.x],
            "py":[fromPoint.y,toPoint.y]
         },null,null,Tween.SIN06);
      }
      
      private static function fly(eff:Effect, fromPoint:Point, toPoint:Point) : void
      {
         Tween.to(eff,10 * 50,{
            "px":[fromPoint.x,toPoint.x],
            "py":[fromPoint.y,toPoint.y]
         });
      }
      
      public static function flyEffGlobal(exp:int) : void
      {
         var p:Point = null;
         var t:MyTextField = null;
         var sId:int = 0;
         p = UIManager.mainMenu.getExpBarXY();
         p.y += 72;
         flyEff(new Point(GameUnitManager.hero.global_x - CameraManager.sightX,GameUnitManager.hero.global_y - CameraManager.sightY),p);
         t = ComponentUtil.getTextField("+" + exp);
         t.size = 20;
         t.bold = true;
         t.color = 65280;
         sId = int(setTimeout(function():void
         {
            GameScene.uiLayer.addChild(t);
            t.alpha = 0;
            Tween.to(t,1500,{
               "x":[p.x,p.x],
               "y":[p.y + 50,p.y - 150],
               "alpha":[1,1]
            },function():void
            {
               if(GameScene.uiLayer.contains(t))
               {
                  GameScene.uiLayer.removeChild(t);
               }
               t.bold = false;
               t.dispose();
            },null,Tween.SIN06);
            clearTimeout(sId);
         },400));
      }
      
      public static function effWord(str:String, _p:Point) : void
      {
         var sp:Sprite = null;
         var tf:MyTextField = null;
         sp = new Sprite();
         sp.x = _p.x;
         sp.y = _p.y;
         tf = ComponentUtil.getTextField(str,sp,{
            "size":18,
            "bold":true,
            "color":16711833
         });
         sp.addChild(tf);
         GameScene.upUILayer.addChild(sp);
         tf.bold = true;
         tf.x = -tf.width / 2;
         tf.y = -tf.height / 2;
         Tween.to(sp,1000,{
            "alpha":[1,0.3],
            "scaleX":[1,3],
            "scaleY":[1,3]
         },function():void
         {
            GameScene.upUILayer.removeChild(sp);
            sp = null;
         },null,Tween.SIN06);
      }
      
      public static function showEff(thing:Array) : void
      {
         var type:int = 0;
         var item:Vo_equip = null;
         var vo:Vo_item = null;
         var len:int = int(thing.length);
         var p:Point = new Point(GameUnitManager.hero.global_x - CameraManager.sightX - 34,GameUnitManager.hero.global_y - CameraManager.sightY - 34);
         var i:uint = 0;
         while(i < len)
         {
            type = int(thing[i][0]);
            if(type == Enum_thing_type.EQUIP)
            {
               item = new Vo_equip();
               item.id = thing[i][1];
               item.Init_lib();
               Tween.gridToBagBezierFuncDef(item,-1,p.x + (34 + 5) * i,p.y);
            }
            else if(type == Enum_thing_type.ITEM)
            {
               vo = new Vo_item();
               vo.id = thing[i][1];
               vo.Init_lib();
               Tween.gridToBagBezierFuncDef(vo,-1,p.x + (34 + 5) * i,p.y);
            }
            i++;
         }
      }
   }
}

