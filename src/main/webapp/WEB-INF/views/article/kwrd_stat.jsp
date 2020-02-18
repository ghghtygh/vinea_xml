<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>현황분석 페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- JQUERY, JAVASCRIPT -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!--  CSS -->
<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/resources/css/style.css">
<link href="/resources/css/_bootswatch.scss" rel="stylesheet">
<link href="/resources/css/_variables.scss" rel="stylesheet">

<!-- Chart.js 사용(라인, 바, 플롯, 레이더 등 사용) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>

<!-- 워드클라우드 -->
<!-- zingchart 
<link href="https://fonts.googleapis.com/css?family=Crete+Round" rel="stylesheet">
<script src="https://cdn.zingchart.com/zingchart.min.js"></script>
-->
<!--  anychart -->
<script src="https://cdn.anychart.com/releases/v8/js/anychart-base.min.js"></script>
<script src="https://cdn.anychart.com/releases/v8/js/anychart-tag-cloud.min.js"></script>
<style>
/** 분야 선택 SelectBox **/
#ctgrnm {
	position: relative;
	width: 500px;
	border: 1px solid #999;
	z-index=1;
}

</style>
</head>
<body>
	<div class="wrapper d-flex align-items-stretch">
		<!-- 전체 메뉴 사이드바 -->
		<nav id="sidebar">
			<div class="p-4 pt-5">
				<a href="/article" class="img logo rounded-circle mb-5" style="background-image: url(/resources/image/analyticx.png);"></a>
				<ul class="list-unstyled components mb-5">
					<li>
						<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">메인</a>
						<ul class="collapse list-unstyled" id="homeSubmenu">
						<li>
							<a href="/article">논문보기</a>
						</li>
						</ul>
					</li>
						<!-- 키워드 동향 페이지에서는 '현황>키워드 현황'을 선택상태로 둠 -->
						<li class="active">
							<a href="#pageSubmenu" data-toggle="collapse" aria-expanded="true" class="dropdown-toggle">현황</a>
							<ul class="list-unstyled collapse show in" id="pageSubmenu" aria-expanded="true">
								<li>
									<a href="/article/yearstat">연도별 현황</a>
								</li>
								<li>
									<a href="/article/orgnstat">소속기관별 현황</a>
								</li>
								<li>
									<a href="/article/ctgrstat">분야별 현황</a>
								</li>
								<li class="active">
									<a href="/article/kwrdstat">키워드 현황</a>
								</li>
							</ul>
						</li>
				</ul>
				<div class="footer">
					<p>
						<script>
							document.write(new Date().getFullYear());
						</script>
							About XML Parsing
							<i class="icon-heart" aria-hidden="true"></i>
					</p>
					<p>
						made with by JuHyeon&Minjin 
						<a href="https://github.com/ghghtygh/vinea_xml.git" style="font-size: 12px" target="_blank">
							https://github.com/ghghtygh/vinea_xml.git
						</a>
				</div>
			</div>
		</nav>
		<!-- 메뉴에서 키워드 현황을 클릭하였을 때 결과 페이지  -->
		<div id="content" class="p-4 p-md-5">
			<nav class="navbar navbar-expand-lg navbar-light bg-light">
				<div class="container-fluid">
					<button type="button" id="sidebarCollapse" class="btn btn-primary">
						<i class="fa fa-bars"></i> <span class="sr-only">Toggle Menu</span>
					</button>
					<button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
						<i class="fa fa-bars"></i>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
						<ul class="nav navbar-nav ml-auto">
							<li class="nav-item active"><a class="nav-link" href="/article">Home</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!-- tab 정의 -->
			<ul class="nav nav-tabs">
				<li class="nav-item">
					<a class="nav-link active" href="#kwrd1" data-toggle="tab">키워드별 현황</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#kwrd2" data-toggle="tab">분야별 키워드</a>
				</li>
			</ul>
			<div class="tab-content">
			<!-- 첫번째 tab에 들어갈 내용(시작) -->
			<!-- tab 정의 부분에서의 href 속성과 동일하게 id를 각각 지정 -->
			<div class="tab-pane active" id="kwrd1">
				<p style="font-size: 20px; font-weight: bold; color: #000069; margin-top: 20px">(키워드명)을 포함한 논문목록</p>
				<div class="row">
				<div class="col-lg-12">
				<table style="text-align: center;" class="table table-hover">
					<tbody>
						<th style="border-top: 2px solid #000069">순번</th>
						<th style="border-top: 2px solid #000069">학술지명</th>
						<th style="border-top: 2px solid #000069">논문제목</th>
						<th style="border-top: 2px solid #000069">발행연도</th>
						<th style="border-top: 2px solid #000069">권(호)</th>
						<tr>
							<td style="border-top: 1px solid #b4b4b4">논문순번..</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">학술지명..</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								<a href="#">제목..</a>
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								발행연도..
							</td>
							<td style="border-top: 1px solid #b4b4b4">
								권(호)..
							</td>
						</tr>
					</tbody>
				</table>
				</div>
				</div>
				<!-- 페이징 처리 시작 -->
				<div style="width: 100%;">
					<div align="right" style="position: relative;">
						<div style="position: absolute; text-align: center; width: 100%;">
							<div class="btn-group mr-2">
								<c:choose>
									<c:when test="${pager.nowPage ne 1 }">
										<a href='#' class="btn btn-primary" onClick="fn_paging(1)">처음</a>
									</c:when>
									<c:otherwise>
										<a class="btn btn-primary disabled">처음</a>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${pager.nowPage ne 1 }">
										<a href="#" class="btn btn-primary" onClick="fn_paging('${pager.prevPage}')">&laquo;</a>
									</c:when>
									<c:otherwise>
										<a class="btn btn-primary disabled">&laquo;</a>
									</c:otherwise>
								</c:choose>
								<c:forEach begin="${pager.startPage}" end="${pager.endPage}" var="pageNum">
									<c:choose>
										<c:when test="${pageNum eq pager.nowPage}">
											<a href="#" class="btn btn-primary active" onClick="fn_paging('${pageNum}')">${pageNum }</a>
										</c:when>
										<c:otherwise>
											<a href="#" class="btn btn-primary" onClick="fn_paging('${pageNum}')">${pageNum}</a>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:choose>
									<c:when test="${pager.nowPage ne pager.pageCnt && pager.pageCnt > 0 }">
										<a class="btn btn-primary" href="#" onClick="fn_paging('${pager.nextPage}')">&raquo;</a>
									</c:when>
									<c:otherwise>
										<a class="btn btn-primary disabled">&raquo;</a>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${pager.nowPage ne pager.pageCnt }">
										<a class="btn btn-primary" href="#" onClick="fn_paging('${pager.pageCnt}')">끝</a>
									</c:when>
									<c:otherwise>
										<a class="btn btn-primary disabled">끝</a>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
				<!-- 페이징 처리 끝 -->
				<p style="font-size: 20px; font-weight: bold; color: #000069; margin-top: 100px">(키워드명)을 포함한 논문수</p>
				<!-- 해당 키워드의 논문수 -->
				<div class="row" style="margin-top: 20px">
					<div class="col-lg-12">
					<canvas id="myChart" height="50"></canvas>
					</div>
				</div>
				<script>
				new Chart(document.getElementById("myChart"), {
				    type: 'bar',
				    data: {
				      labels: ["2015", "2016", "2017", "2018", "2019"],
				      datasets: [
				        {
				          label: "논문 수",
				          backgroundColor: ["#8e5ea2", "#8e5ea2","#8e5ea2","#8e5ea2","#8e5ea2"],
				          data: [0,0,5267,0,0]
				        }
				      ]
				    },
				    options: {
				      legend: { display: false }
				    }
				});
				</script>
				<!--  <script>
				    /** zingchart 라이센스, 모듈 사용 **/
				 	ZC.LICENSE = ["569d52cefae586f634c54f86dc99e6a9", "b55b025e438fa8a98e32482b5f768ff5"];
				    zingchart.MODULESDIR = 'https://cdn.zingchart.com/modules/';
				 
				    /** wordcloud를 그리기 위한 키워드 빈도 데이터가 들어갈 부분 **/
				    var myConfig = {
				      type: 'wordcloud',
				      options: {
				        text: 'It is a rare honor in this life to follow one of your heroes.  And John Lewis is one of my heroes. Now, I have to imagine that when a younger John Lewis woke up that morning 50 years ago and made his way to Brown Chapel, heroics were not on his mind.  A day like this was not on his mind.  Young folks with bedrolls and backpacks were milling about.  Veterans of the movement trained newcomers in the tactics of non-violence; the right way to protect yourself when attacked.  A doctor described what tear gas does to the body, while marchers scribbled down instructions for contacting their loved ones.  The air was thick with doubt, anticipation and fear.  And they comforted themselves with the final verse of the final hymn they sung: “No matter what may be the test, God will take care of you; Lean, weary one, upon His breast, God will take care of you.” And then, his knapsack stocked with an apple, a toothbrush, and a book on government -- all you need for a night behind bars -- John Lewis led them out of the church on a mission to change America. President and Mrs. Bush, Governor Bentley, Mayor Evans, Sewell, Reverend Strong, members of Congress, elected officials, foot soldiers, friends, fellow Americans: As John noted, there are places and moments in America where this nation’s destiny has been decided.  Many are sites of war -- Concord and Lexington, Appomattox, Gettysburg.  Others are sites that symbolize the daring of America’s character -- Independence Hall and Seneca Falls, Kitty Hawk and Cape Canaveral. Selma is such a place.  In one afternoon 50 years ago, so much of our turbulent history -- the stain of slavery and anguish of civil war; the yoke of segregation and tyranny of Jim Crow; the death of four little girls in Birmingham; and the dream of a Baptist preacher -- all that history met on this bridge. It was not a clash of armies, but a clash of wills; a contest to determine the true meaning of America.  And because of men and women like John Lewis, Joseph Lowery, Hosea Williams, Amelia Boynton, Diane Nash, Ralph Abernathy, C.T. Vivian, Andrew Young, Fred Shuttlesworth, Dr. Martin Luther King, Jr., and so many others, the idea of a just America and a fair America, an inclusive America, and a generous America -- that idea ultimately triumphed. As is true across the landscape of American history, we cannot examine this moment in isolation.  The march on Selma was part of a broader campaign that spanned generations; the leaders that day part of a long line of heroes. We gather here to celebrate them.  We gather here to honor the courage of ordinary Americans willing to endure billy clubs and the chastening rod; tear gas and the trampling hoof; men and women who despite the gush of blood and splintered bone would stay true to their North Star and keep marching towards justice. They did as Scripture instructed:  “Rejoice in hope, be patient in tribulation, be constant in prayer.”  And in the days to come, they went back again and again.  When the trumpet call sounded for more to join, the people came –- black and white, young and old, Christian and Jew, waving the American flag and singing the same anthems full of faith and hope.  A white newsman, Bill Plante, who covered the marches then and who is with us here today, quipped that the growing number of white people lowered the quality of the singing.  (Laughter.)  To those who marched, though, those old gospel songs must have never sounded so sweet. In time, their chorus would well up and reach President Johnson.  And he would send them protection, and speak to the nation, echoing their call for America and the world to hear:  “We shall overcome.”  (Applause.)  What enormous faith these men and women had.  Faith in God, but also faith in America.The Americans who crossed this bridge, they were not physically imposing.  But they gave courage to millions.  They held no elected office.  But they led a nation.  They marched as Americans who had endured hundreds of years of brutal violence, countless daily indignities –- but they didn’t seek special treatment, just the equal treatment promised to them almost a century before.  (Applause.) What they did here will reverberate through the ages.  Not because the change they won was preordained; not because their victory was complete; but because they proved that nonviolent change is possible, that love and hope can conquer hate. As we commemorate their achievement, we are well-served to remember that at the time of the marches, many in power condemned rather than praised them.  Back then, they were called Communists, or half-breeds, or outside agitators, sexual and moral degenerates, and worse –- they were called everything but the name their parents gave them.  Their faith was questioned.  Their lives were threatened.  Their patriotism challenged. And yet, what could be more American than what happened in this place?  (Applause.)  What could more profoundly vindicate the idea of America than plain and humble people –- unsung, the downtrodden, the dreamers not of high station, not born to wealth or privilege, not of one religious tradition but many, coming together to shape their country’s course? What greater expression of faith in the American experiment than this, what greater form of patriotism is there than the belief that America is not yet finished, that we are strong enough to be self-critical, that each successive generation can look upon our imperfections and decide that it is in our power to remake this nation to more closely align with our highest ideals?  (Applause.) That’s why Selma is not some outlier in the American experience.  That’s why it’s not a museum or a static monument to behold from a distance.  It is instead the manifestation of a creed written into our founding documents:  “We the People…in order to form a more perfect union.”  “We hold these truths to be self-evident, that all men are created equal.”  (Applause.) These are not just words.  They’re a living thing, a call to action, a roadmap for citizenship and an insistence in the capacity of free men and women to shape our own destiny.  For founders like Franklin and Jefferson, for leaders like Lincoln and FDR, the success of our experiment in self-government rested on engaging all of our citizens in this work.  And that’s what we celebrate here in Selma.  That’s what this movement was all about, one leg in our long journey toward freedom.  (Applause.) The American instinct that led these young men and women to pick up the torch and cross this bridge, that’s the same instinct that moved patriots to choose revolution over tyranny.  It’s the same instinct that drew immigrants from across oceans and the Rio Grande; the same instinct that led women to reach for the ballot, workers to organize against an unjust status quo; the same instinct that led us to plant a flag at Iwo Jima and on the surface of the Moon.  (Applause.) It’s the idea held by generations of citizens who believed that America is a constant work in progress; who believed that loving this country requires more than singing its praises or avoiding uncomfortable truths. It requires the occasional disruption, the willingness to speak out for what is right, to shake up the status quo.  That’s America.  (Applause.) That’s what makes us unique.  That’s what cements our reputation as a beacon of opportunity.  Young people behind the Iron Curtain would see Selma and eventually tear down that wall.  Young people in Soweto would hear Bobby Kennedy talk about ripples of hope and eventually banish the scourge of apartheid.  Young people in Burma went to prison rather than submit to military rule.  They saw what John Lewis had done.  From the streets of Tunis to the Maidan in Ukraine, this generation of young people can draw strength from this place, where the powerless could change the world’s greatest power and push their leaders to expand the boundaries of freedom. They saw that idea made real right here in Selma, Alabama.  They saw that idea manifest itself here in America. Because of campaigns like this, a Voting Rights Act was passed.  Political and economic and social barriers came down.  And the change these men and women wrought is visible here today in the presence of African Americans who run boardrooms, who sit on the bench, who serve in elected office from small towns to big cities; from the Congressional Black Caucus all the way to the Oval Office.  (Applause.) Because of what they did, the doors of opportunity swung open not just for black folks, but for every American.  Women marched through those doors.  Latinos marched through those doors.  Asian Americans, gay Americans, Americans with disabilities -- they all came through those doors.  (Applause.)  Their endeavors gave the entire South the chance to rise again, not by reasserting the past, but by transcending the past. What a glorious thing, Dr. King might say.  And what a solemn debt we owe.  Which leads us to ask, just how might we repay that debt? First and foremost, we have to recognize that one day’s commemoration, no matter how special, is not enough.  If Selma taught us anything, it’s that our work is never done.  (Applause.)  The American experiment in self-government gives work and purpose to each generation. Selma teaches us, as well, that action requires that we shed our cynicism.  For when it comes to the pursuit of justice, we can afford neither complacency nor despair. Just this week, I was asked whether I thought the Department of Justice’s Ferguson report shows that, with respect to race, little has changed in this country.  And I understood the question; the report’s narrative was sadly familiar.  It evoked the kind of abuse and disregard for citizens that spawned the Civil Rights Movement.  But I rejected the notion that nothing’s changed.  What happened in Ferguson may not be unique, but it’s no longer endemic.  It’s no longer sanctioned by law or by custom.  And before the Civil Rights Movement, it most surely was.  (Applause.) We do a disservice to the cause of justice by intimating that bias and discrimination are immutable, that racial division is inherent to America.  If you think nothing’s changed in the past 50 years, ask somebody who lived through the Selma or Chicago or Los Angeles of the 1950s.  Ask the female CEO who once might have been assigned to the secretarial pool if nothing’s changed.  Ask your gay friend if it’s easier to be out and proud in America now than it was thirty years ago.  To deny this progress, this hard-won progress -– our progress –- would be to rob us of our own agency, our own capacity, our responsibility to do what we can to make America better. Of course, a more common mistake is to suggest that Ferguson is an isolated incident; that racism is banished; that the work that drew men and women to Selma is now complete, and that whatever racial tensions remain are a consequence of those seeking to play the “race card” for their own purposes.  We don’t need the Ferguson report to know that’s not true.  We just need to open our eyes, and our ears, and our hearts to know that this nation’s racial history still casts its long shadow upon us. We know the march is not yet over.  We know the race is not yet won.  We know that reaching that blessed destination where we are judged, all of us, by the content of our character requires admitting as much, facing up to the truth.  “We are capable of bearing a great burden,” James Baldwin once wrote, “once we discover that the burden is reality and arrive where reality is.” There’s nothing America can’t handle if we actually look squarely at the problem.  And this is work for all Americans, not just some.  Not just whites.  Not just blacks.  If we want to honor the courage of those who marched that day, then all of us are called to possess their moral imagination.  All of us will need to feel as they did the fierce urgency of now.  All of us need to recognize as they did that change depends on our actions, on our attitudes, the things we teach our children.  And if we make such an effort, no matter how hard it may sometimes seem, laws can be passed, and consciences can be stirred, and consensus can be built.  (Applause.)  With such an effort, we can make sure our criminal justice system serves all and not just some.  Together, we can raise the level of mutual trust that policing is built on –- the idea that police officers are members of the community they risk their lives to protect, and citizens in Ferguson and New York and Cleveland, they just want the same thing young people here marched for 50 years ago -– the protection of the law.  (Applause.)  Together, we can address unfair sentencing and overcrowded prisons, and the stunted circumstances that rob too many boys of the chance to become men, and rob the nation of too many men who could be good dads, and good workers, and good neighbors.  (Applause.) With effort, we can roll back poverty and the roadblocks to opportunity.  Americans don’t accept a free ride for anybody, nor do we believe in equality of outcomes.  But we do expect equal opportunity.  And if we really mean it, if we’re not just giving lip service to it, but if we really mean it and are willing to sacrifice for it, then, yes, we can make sure every child gets an education suitable to this new century, one that expands imaginations and lifts sights and gives those children the skills they need.  We can make sure every person willing to work has the dignity of a job, and a fair wage, and a real voice, and sturdier rungs on that ladder into the middle class. And with effort, we can protect the foundation stone of our democracy for which so many marched across this bridge –- and that is the right to vote.  (Applause.)  Right now, in 2015, 50 years after Selma, there are laws across this country designed to make it harder for people to vote.  As we speak, more of such laws are being proposed.  Meanwhile, the Voting Rights Act, the culmination of so much blood, so much sweat and tears, the product of so much sacrifice in the face of wanton violence, the Voting Rights Act stands weakened, its future subject to political rancor. How can that be?  The Voting Rights Act was one of the crowning achievements of our democracy, the result of Republican and Democratic efforts.  (Applause.)  President Reagan signed its renewal when he was in office.  President George W. Bush signed its renewal when he was in office.  (Applause.)  One hundred members of Congress have come here today to honor people who were willing to die for the right to protect it.  If we want to honor this day, let that hundred go back to Washington and gather four hundred more, and together, pledge to make it their mission to restore that law this year.  That’s how we honor those on this bridge.  (Applause.) Of course, our democracy is not the task of Congress alone, or the courts alone, or even the President alone.  If every new voter-suppression law was struck down today, we would still have, here in America, one of the lowest voting rates among free peoples.  Fifty years ago, registering to vote here in Selma and much of the South meant guessing the number of jellybeans in a jar, the number of bubbles on a bar of soap.  It meant risking your dignity, and sometimes, your life. What’s our excuse today for not voting?  How do we so casually discard the right for which so many fought?  (Applause.)  How do we so fully give away our power, our voice, in shaping America’s future?  Why are we pointing to somebody else when we could take the time just to go to the polling places?  (Applause.)  We give away our power. Fellow marchers, so much has changed in 50 years.  We have endured war and we’ve fashioned peace.  We’ve seen technological wonders that touch every aspect of our lives.  We take for granted conveniences that our parents could have scarcely imagined.  But what has not changed is the imperative of citizenship; that willingness of a 26-year-old deacon, or a Unitarian minister, or a young mother of five to decide they loved this country so much that they’d risk everything to realize its promise. That’s what it means to love America.  That’s what it means to believe in America.  That’s what it means when we say America is exceptional.For we were born of change.  We broke the old aristocracies, declaring ourselves entitled not by bloodline, but endowed by our Creator with certain inalienable rights.  We secure our rights and responsibilities through a system of self-government, of and by and for the people.  That’s why we argue and fight with so much passion and conviction -- because we know our efforts matter.  We know America is what we make of it. Look at our history.  We are Lewis and Clark and Sacajawea, pioneers who braved the unfamiliar, followed by a stampede of farmers and miners, and entrepreneurs and hucksters.  That’s our spirit.  That’s who we are. We are Sojourner Truth and Fannie Lou Hamer, women who could do as much as any man and then some.  And we’re Susan B. Anthony, who shook the system until the law reflected that truth.  That is our character. We’re the immigrants who stowed away on ships to reach these shores, the huddled masses yearning to breathe free –- Holocaust survivors, Soviet defectors, the Lost Boys of Sudan.  We’re the hopeful strivers who cross the Rio Grande because we want our kids to know a better life.  That’s how we came to be.  (Applause.) We’re the slaves who built the White House and the economy of the South.  (Applause.)  We’re the ranch hands and cowboys who opened up the West, and countless laborers who laid rail, and raised skyscrapers, and organized for workers’ rights. We’re the fresh-faced GIs who fought to liberate a continent.  And we’re the Tuskeegee Airmen, and the Navajo code-talkers, and the Japanese Americans who fought for this country even as their own liberty had been denied. We’re the firefighters who rushed into those buildings on 9/11, the volunteers who signed up to fight in Afghanistan and Iraq.  We’re the gay Americans whose blood ran in the streets of San Francisco and New York, just as blood ran down this bridge. (Applause.) We are storytellers, writers, poets, artists who abhor unfairness, and despise hypocrisy, and give voice to the voiceless, and tell truths that need to be told. We’re the inventors of gospel and jazz and blues, bluegrass and country, and hip-hop and rock and roll, and our very own sound with all the sweet sorrow and reckless joy of freedom. We are Jackie Robinson, enduring scorn and spiked cleats and pitches coming straight to his head, and stealing home in the World Series anyway.  (Applause.) We are the people Langston Hughes wrote of who “build our temples for tomorrow, strong as we know how.”  We are the people Emerson wrote of, “who for truth and honor’s sake stand fast and suffer long;” who are “never tired, so long as we can see far enough.” That’s what America is.  Not stock photos or airbrushed history, or feeble attempts to define some of us as more American than others.  (Applause.)  We respect the past, but we don’t pine for the past.  We don’t fear the future; we grab for it.  America is not some fragile thing.  We are large, in the words of Whitman, containing multitudes.  We are boisterous and diverse and full of energy, perpetually young in spirit.  That’s why someone like John Lewis at the ripe old age of 25 could lead a mighty march. And that’s what the young people here today and listening all across the country must take away from this day.  You are America.  Unconstrained by habit and convention.  Unencumbered by what is, because you’re ready to seize what ought to be. For everywhere in this country, there are first steps to be taken, there’s new ground to cover, there are more bridges to be crossed.  And it is you, the young and fearless at heart, the most diverse and educated generation in our history, who the nation is waiting to follow. Because Selma shows us that America is not the project of any one person.  Because the single-most powerful word in our democracy is the word “We.”  “We The People.”  “We Shall Overcome.”  “Yes We Can.”  (Applause.)  That word is owned by no one.  It belongs to everyone.  Oh, what a glorious task we are given, to continually try to improve this great nation of ours. Fifty years from Bloody Sunday, our march is not yet finished, but we’re getting closer.  Two hundred and thirty-nine years after this nation’s founding our union is not yet perfect, but we are getting closer.  Our job’s easier because somebody already got us through that first mile.  Somebody already got us over that bridge.  When it feels the road is too hard, when the torch we’ve been passed feels too heavy, we will remember these early travelers, and draw strength from their example, and hold firmly the words of the prophet Isaiah:  “Those who hope in the Lord will renew their strength.  They will soar on [the] wings like eagles.  They will run and not grow weary.  They will walk and not be faint.”  (Applause.) We honor those who walked so we could run.  We must run so our children soar.  And we will not grow weary.  For we believe in the power of an awesome God, and we believe in this country’s sacred promise. May He bless those warriors of justice no longer with us, and bless the United States of America.  Thank you, everybody.  (Applause.)',
				        minLength: 5,
				        /* 불용어 처리 */
				        ignore: ["America", "American", "Applause", "Because", "because", "could", "don’t", "people", "That’s", "that’s", "Their", "their", "there", "these", "thing", "those", "through", "We’re", "we’re", "where", "would"],
				        maxItems: 40,
				        aspect: 'flow-center',		
				        style: {
				          fontFamily: 'Crete Round',				 
				          hoverState: {
				            backgroundColor: '#dcdcdc',
				            borderRadius: 3,
				            fontColor: 'black'
				          },
				          /* 키워드명: 빈도수를  tooltip으로 보여줌 */
				          tooltip: {
				            text: '%text: %hits',
				            visible: true,
				            alpha: 0.9,
				            backgroundColor: '#FAEBCD',
				            borderRadius: 2,
				            borderColor: 'none',
				            fontColor: 'black',
				            fontFamily: 'Georgia',
				            textAlpha: 1
				          }
				        }
				      },				 
				    };
				    
				    zingchart.click = function(c)
				    {
				    	//alert(myConfig.options["style"]["tooltip"].toString())
				    	console.log(myConfig.options["style"]["tooltip"].text.toString())
				    }
				 
				    /** 지정한 옵션에 따라서 워드클라우드를 띄움 **/
				    zingchart.render({
				      id: "kwrdcloud",
				      data: myConfig,
				      height: 400,
				      width: '100%'
				    });	
				</script>-->
			</div>
			<!-- 첫번째 tab에 들어갈 내용(끝) -->
			<!-- 두번째 tab에 들어갈 내용(시작) -->
			<div class="tab-pane" id="kwrd2">
			<div id="ctgr_kwrd1" style="margin-top: 20px">
				<ol class="breadcrumb">
					<!--분야 선택-->
					<li class="breadcrumb-item">
						<p style="font-size: 15px; font-weight: bold; margin-right: 10px; color: #000">분야</p>
					</li>
					<select class="form-control" id="ctgrnm">
						<optgroup label="분야명1">
							<option value="주제명1">주제명1</option>
							<option value="주제명2">주제명2..</option>
						</optgroup>
						<optgroup label="분야명2">
							<option value="주제명1">주제명1</option>
							<option value="주제명2">주제명2..</option>
						</optgroup>
						<optgroup label="분야명3">
							<option value="주제명1">주제명1</option>
							<option value="주제명2">주제명2..</option>
						</optgroup>
						<optgroup label="분야명4">
							<option value="주제명1">주제명1</option>
							<option value="주제명2">주제명2..</option>
						</optgroup>
						<optgroup label="분야명5">
							<option value="주제명1">주제명1</option>
							<option value="주제명2">주제명2..</option>
						</optgroup>
					</select>
				</ol>
				<p style="font-size: 20px; font-weight: bold; color: #000069; margin-top: 50px">(선택 분야명)키워드 빈도수</p>
				<!-- 키워드 빈도를 보기 위한 워드클라우드 생성 -->
				<div id="kwrdcloud" style="height: 500px; width: 800px; margin-left: 400px"></div>
				<script>
					anychart.onDocumentReady(function(){
						var data = [
							{"x": "engineer", value: 80},
						    {"x": "information", value: 56},
						    {"x": "psyics", value: 44},
						    {"x": "matlab", value: 40},
						    {"x": "communication", value: 36},
						    {"x": "math", value: 32},
						    {"x": "earth", value: 28},
						    {"x": "computer", value: 24},
						    {"x": "java", value: 400},
						    {"x": "C", value: 200},
						    {"x": "Spring", value: 350},
						    {"x": "MVC", value: 150},
						    {"x": "Android", value: 100},
						    {"x": "Python", value: 350},
						    {"x": "program", value: 150},
						    {"x": "C++", value: 150},
						    {"x": "Eclipse", value: 400},
						    {"x": "a", value: 32},
						    {"x": "b", value: 45},
						    {"x": "c", value: 15},
						    {"x": "d", value: 20},
						    {"x": "e", value: 75},
						    {"x": "f", value: 80},
						  ];
						
						var chart = anychart.tagCloud(data);
						var formatter = "{%value}";
						var tooltip = chart.tooltip();
						
						chart.angles([0, 90, 90])
						chart.width = "800px";
						chart.height = "400px";
						chart.container("kwrdcloud");
						chart.draw();	
						tooltip.format(formatter);
						
						chart.listen("pointClick", function(e) {
							
							/* var url = "키워드 해당 논문 경로" + e.point.get("x"); */
							alert(e.point.get("x"));
							console.log(e.point.get("x"));
						});
						
					});
				</script>
			</div>
			</div>
			</div>
		</div>
	</div>
<!-- JQUERY, 필요한 JAVASCRIPT 파일 -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/popper.js"></script>
<script src="/resources/js/bootstrap.min.js"></script>
<script src="/resources/js/main.js"></script>
</body>
</html>