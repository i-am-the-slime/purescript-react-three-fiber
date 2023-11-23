module React.Three.Component where

import Prelude
import Effect.Unsafe (unsafePerformEffect)
import React.Basic.DOM as React

c = unsafePerformEffect <<< React.unsafeCreateDOMComponent

mesh = c "mesh"
points = c "points"

-- Geometries
boxGeometry = c "boxGeometry"
planeGeometry = c "planeGeometry"
cylinderGeometry = c "cylinderGeometry"
coneGeometry = c "coneGeometry"
circleGeometry = c "circleGeometry"
sphereGeometry = c "sphereGeometry"
sphereBufferGeometry = c "sphereBufferGeometry"
dodecahedronGeometry = c "dodecahedronGeometry"
icosahedronGeometry = c "icosahedronGeometry"
octahedronGeometry = c "octahedronGeometry"
tetrahedronGeometry = c "tetrahedronGeometry"
torusGeometry = c "torusGeometry"
torusKnotGeometry = c "torusKnotGeometry"
tubeGeometry = c "tubeGeometry"
latheGeometry = c "latheGeometry"
parametricGeometry = c "parametricGeometry"
edgesGeometry = c "edgesGeometry"
extrudeGeometry = c "extrudeGeometry"
shapeGeometry = c "shapeGeometry"
textGeometry = c "textGeometry"
convexGeometry = c "convexGeometry"
decalGeometry = c "decalGeometry"
roundedBoxGeometry = c "roundedBoxGeometry"

-- Materials
meshStandardMaterial = c "meshStandardMaterial"
meshBasicMaterial = c "meshBasicMaterial"
meshLambertMaterial = c "meshLambertMaterial"
meshPhongMaterial = c "meshPhongMaterial"
meshToonMaterial = c "meshToonMaterial"
meshNormalMaterial = c "meshNormalMaterial"
meshDepthMaterial = c "meshDepthMaterial"
meshDistanceMaterial = c "meshDistanceMaterial"
meshMatcapMaterial = c "meshMatcapMaterial"
pointsMaterial = c "pointsMaterial"

-- Lights
ambientLight = c "ambientLight"
pointLight = c "pointLight"
directionalLight = c "directionalLight"
hemisphereLight = c "hemisphereLight"
rectAreaLight = c "rectAreaLight"
spotLight = c "spotLight"
