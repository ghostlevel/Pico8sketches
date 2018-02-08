pico-8 cartridge // http://www.pico-8.com
version 15
__lua__
  
// 2016/03
// by zproc / lotek.fr / ghostlevel.net

pi = 3.141592653589793
t=0
z=10
p=0
launch = time()
text = {}
sx=128
t=0
k=0
tilt2=true
tilt3=true

function initscroll()
 local t = "the  dominant,  continuing  search  for  a noiseless channel has been, and will always be  no  more  than  a  regrettable,  ill-fated dogma."
 
 for i = 1, #t do
  text[i] = sub(t,i,i)
 end
end

function scroll()
  sx = sx-0.5
  
  for j=1,#text do
   --sy = cos(4*k/128)*4+100

   k = sx+j*6-t
   print(text[j], k, 120)
  end
  --print ("k"..k)
  if (k<-50) then
   k = 200
   sx = 128
   t=0
  end
end

-- yep, yep, don't know.
function displace()
 pimg=0
 local t=time()-launch
 for y=0,126 do
  local off = 16 * sin((y + flr(t*50 + 0.5) + 0.5) / 126)
  addr = 0x6000+64*y
  local x = flr(off/2 + 0.5) % 126

  ya = cos(4*x/128)*10+80

  memcpy(pimg,addr,126)
  memcpy(addr+ya,0x6000,64-y)
  if (tilt2) then memcpy(addr,pimg-x,126) end
  if (tilt3) then memcpy(addr,pimg-ya,126) end

  for pk=1,4 do
   poke(addr+rnd(ya), rnd(p))
   poke(addr+rnd(ya), rnd(p))
  end
  pimg+=126
 end
end

function dogma()
 print("the  dominant,  continuing")  
 print("search  for  a noiseless") 
 print("channel has been, and will")
 print("always be  no  more  than  a")
 print("regrettable,  ill-fated dogma.")
end

function _init()
  initscroll()
  music(0)
end

function _update()
 p+=0.05
 t+=1
 
 if(t%60==0) then
 
 r=rnd(10)
 if(r>7) then 
  tilt2=true
  tilt3=false
  elseif (r>5) then
    tilt2 = false
    tilt3 = false
  else
    tilt2 = false
    tilt3 = true
  end
  --print(tilt, 0, 110)
--end
 end
end


function _draw()
	--rectfill(0,0,127,127,0)
 cls()
 for d=1, 4 do dogma() end
 
 displace()
 scroll()
 

 --for c=0,15,2 do
  --pal(c,(c+p)%16,1)
 --end
 
end
__sfx__
0001001f0230002000020000200002000020000230002300023060b006150061f0062100621006210062200622000220001e0001a00015000120000000000000000000b0000d0001600000000000000000000000
__music__
03 00000000

