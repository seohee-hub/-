제목 <h>
굵게 <strong>
밑줄 <u>
줄바꿈 <br>
★ 단락 그룹핑 </p> <p>
   p태그를 통해서 단락의 경계를 분명히 하면서
   CSS로 p태그의 디자인을 자유롭게 변경할 수 있기 때문에 br 태그 보다 p 태그가 더 좋은 선택
target="_blank" 새창에서 링크 건 페이지 열리기
메뉴 <li> 
메뉴구분 <ul> 
  ul은 unordered list의 약자이고, 순서없음
  ol은 ordered list의 약자랍니다. 순서대로
※ 본문 <body>
※ 본문설명 <head>

id 학번 같은것, id는 해당 문서에서 한번밖에 사용할 수 없음
class 반(그룹핑)
HTML로서 만들어졌다는 것 <!doctype html>
a는 anchor
href는 HyperText Reference
<table>태그
   <tr>테이블에서 열을 구분
   <th>각 열의 제목, 내용은 굵은글씨에 가운데정렬
   <td>테이블의 열을 각각의 셀로 나눔
   <caption>테이블 상단에 제목이나 짧은 설명
.saw 소스코드에 있는 saw클래스
동일한 level 일 때는 나중에 쓴 선택자가 우선,다른 level 일 때는 id > class > tag 순
<div>= Division(분할, 나누기)-> html에서 웹 페이지의 내용(텍스트, 이미지, 머리글 등)을 구분
                              주로 여러 요소들의 스타일을 한 번에 적용하기 위해 사용
<span> 주로 텍스트의 특정부분에 따로 스타일을 적용
<iframe> 웹 안에 또 다른 웹 페이지를 삽입

<header> HTML문서나 섹션에 대한 헤더
<nav> HTML문서의 탐색링크를 정의
<section> HTML문서에서 섹션
<article> HTML문서에서 독립적인 하나의 글
<aside>	HTML문서에서 페이지 부분 이외의 콘텐츠
<footer> HTML문서나 섹션부분에 대한 푸터

form 요소의 전달 방식
    GET 방식? 주소에 데이터를 추가하여 전달
       데이터가 주소 입력창에 그대로 나타나며, 전송할수 있는 데이터크기 제한적
       검색엔진의 쿼리와 같이 크기가작고 중요도가 낮은정보를 보낼때 주로사용

    POST 방식? 데이터를 별도로 첨부하여 전달
       데이터가 외부에 드러나지 않으며, 전송할수 있는 데이터의크기 제한X
       보안성 및 활용성이 좋다

대표적인 input 요소의 타입
    텍스트 입력(text)
    비밀번호 입력(password)
    라디오 버튼(radio)
    체크박스(checkbox)
    파일 선택(file)
    선택 입력(select)
    문장 입력(textarea)
    버튼 입력(button)
    전송 버튼(submit)
    필드셋(fieldset) (데이터들을 묶어줘서 표시)

document.write이라는 행위 자체는 html 문서에 결과값을 표시
코드<함수<객체 (객체에 속한 함수는 '메소드')
함수에서 뭔가 가지고오려면 return 필요

HTML로는 웹의 내용을 작성하고, CSS로는 웹을 디자인하며, 자바스크립트로는 웹의 동작을 구현

HTML 문서를 XHTML 문서로 변환하는 방법
   1. 첫줄에 다음 코드를 추가합니다.
       <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
       <html xmlns="http://www.w3.org/1999/xhtml">
   2. xmlns 속성을 추가합니다.
   3. 모든 태그 이름을 소문자로 바꿔줍니다.
   4. 모든 빈 태그를 닫아줍니다.
   5. 모든 속성 이름을 소문자로 바꿔줍니다.
   6. 모든 속성값을 따옴표로 둘러쌉니다.

스타일 우선순위
  인라인 스타일? style 속성(html 태그에 style="")
  내부(외부)스타일 시트? style 태그(<head>사이에)
  웹 브라우저 기본 스타일

CSS 선택자(selector)? 스타일을 적용할 HTML 요소를 선택하는데 사용하는 대표적인 선택자
  HTML 요소 선택자
  아이디(id) 선택자
  클래스(class) 선택자

  background	모든 background 속성을 이용한 스타일을 한 줄에 설정할 수 있음.
  background-color	HTML 요소의 배경색을 설정함.
  background-image	HTML 요소의 배경 이미지를 설정함.
  background-repeat	설정된 배경 이미지의 반복 유무를 설정함.
  background-position	반복되지 않는 배경 이미지의 상대 위치를 설정함.
  background-attachment	배경 이미지를 스크롤과는 무관하게 해당 위치에 고정시킴.
  
  color	텍스트의 색상을 설정함.
  direction	텍스트가 쓰이는 방향을 설정함.
  letter-spacing	텍스트 내에서 문자 사이의 간격을 설정함.
  word-spacing	텍스트 내에서 단어 사이의 간격을 설정함.
  text-indent	단락의 첫 줄을 들여쓰기할지 안 할지를 설정함.
  text-align	텍스트의 수평 방향 정렬을 설정함.
  text-decoration	텍스트에 여러 가지 효과를 설정하거나 제거함.
  text-transform	텍스트에 포함된 영문자에 대한 대소문자를 설정함.
  line-height	텍스트의 줄 간격을 설정함.
  text-shadow	텍스트에 그림자 효과를 설정함.
  unicode-bidi	direction 속성과 같이 사용하여 텍스트의 기본 출력 방향을 설정함.
  vertical-align	HTML 요소 내의 수직 방향 정렬을 설정함.
  white-space	HTML 요소 내의 여백을 설정함.
  
  font	모든 font 속성을 이용한 스타일을 한 줄에 설정할 수 있음.
  font-family	텍스트의 글꼴 집합(font family)을 설정함.
  font-style	주로 이탤릭체를 사용하기 위해 사용함.
  font-variant	텍스트에 포함된 영문자 중 소문자만을 작은 대문자(small-caps) 글꼴로 변경시킴.
  font-weight	텍스트를 얼마나 두껍게 표현할지를 설정함.
  font-size	텍스트의 크기를 설정함.
