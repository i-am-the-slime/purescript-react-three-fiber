module React.Three.Fiber where

import Prelude
import Data.Function (on)
import Data.Lens (Lens')
import Data.Lens as Lens
import Data.Lens.Record (prop)
import Data.Nullable (Nullable)
import Data.Symbol (class IsSymbol)
import Effect (Effect)
import Effect.Uncurried (EffectFn1, EffectFn2, EffectFn3, mkEffectFn2, runEffectFn1)
import Prim.Row (class Cons)
import React.Basic (ReactComponent)
import React.Basic.Hooks (Hook, unsafeHook)
import React.Three.Types as Three
import Type.Prelude (Proxy)
import Unsafe.Coerce (unsafeCoerce)

foreign import canvas ∷ ∀ a. ReactComponent a
foreign import data UseFrame ∷ Type → Type → Type
foreign import data UseThree ∷ Type → Type → Type

foreign import useFrameImpl ∷
  ∀ state. EffectFn1 (EffectFn2 state Number Unit) Unit

useFrame ∷ ∀ state. (state → Number → Effect Unit) → Hook (UseFrame state) Unit
useFrame = unsafeHook <<< runEffectFn1 useFrameImpl <<< mkEffectFn2

foreign import useThreeImpl ∷
  ∀ subset. EffectFn1 ({ | ThreeFiberState } → subset) subset

useThree ∷
  ∀ key value others.
  IsSymbol key ⇒
  Cons key value others ThreeFiberState ⇒
  Proxy key →
  -- ({ | ThreeFiberState } → value) →
  -- (Lens' { | ThreeFiberState } value) →
  Hook (UseThree value) value
useThree broxy = unsafeHook $ runEffectFn1 useThreeImpl getter
  where
  getter ∷ { | ThreeFiberState } → value
  getter = Lens.view lens

  lens ∷ Lens' { | ThreeFiberState } value
  lens = prop broxy

type ThreeFiberRootState a =
  ( gl ∷ Three.WebGLRenderer
  , scene ∷ Three.Scene
  , camera ∷ Three.PerspectiveCamera
  , mouse ∷ Three.Vector2
  , clock ∷ Three.Clock
  , vr ∷ Boolean
  , linear ∷ Boolean
  , flat ∷ Boolean
  , frameloop ∷ FrameloopType
  , performance ∷
      { current ∷ Number
      , min ∷ Number
      , max ∷ Number
      , debounce ∷ Number
      , regress ∷ Effect Unit
      }
  , size ∷ { width ∷ Number, height ∷ Number }
  , viewport ∷
      { width ∷ Number
      , height ∷ Number
      , initialDpr ∷ Number
      , dpr ∷ Number
      , factor ∷ Number
      , distance ∷ Number
      , aspect ∷ Number
      , getCurrentViewport ∷
          EffectFn3 (Nullable Camera) (Nullable Three.Vector3) Size Viewport
      }
  | a
  )

type ThreeFiberState =
  (
  | ThreeFiberRootState
      ( {- , set :: EffectFn1 ThreeFiberState  -} get ∷
          Effect (Record (ThreeFiberRootState ()))
      -- invalidate	Request a new render, given that frameloop === 'demand'	() => void
      -- advance	Advance one tick, given that frameloop === 'never'	(timestamp: number, runGlobalEffects?: boolean) => void
      , setSize ∷ EffectFn2 Number Number Unit -- width and height
      , setDpr ∷ EffectFn1 Number Unit
      , onPointerMissed ∷ Effect Unit
      -- , events :: { connected: TargetNode, handlers: Events, connect: (target: TargetNode) => void, disconnect: () => void }
      )
  )

foreign import data FrameloopType ∷ Type

always ∷ FrameloopType
always = unsafeCoerce "always"

demand ∷ FrameloopType
demand = unsafeCoerce "demand"

never ∷ FrameloopType
never = unsafeCoerce "never"

instance Eq FrameloopType where
  eq = eq `on` (unsafeCoerce ∷ _ → String)

foreign import data Size ∷ Type
foreign import data Camera ∷ Type
foreign import data Viewport ∷ Type
