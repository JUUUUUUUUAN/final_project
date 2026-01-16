<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>에러 발생</title>
    <link rel="stylesheet" href="/assets/vendor/css/core.css" />
    <link rel="stylesheet" href="/assets/vendor/css/theme-default.css" />
</head>
<body>
    <div class="container-xxl container-p-y d-flex justify-content-center align-items-center" style="height: 100vh;">
        <div class="card p-5" style="max-width: 600px; width: 100%;">
            <div class="text-center">
                <h2 class="mb-2 mx-2">앗! 에러가 발생했습니다. 😱</h2>
                <p class="mb-4 mx-2">죄송합니다. 요청을 처리하는 중에 문제가 생겼습니다.</p>
                
                <div class="alert alert-danger text-start" role="alert" style="overflow: auto; max-height: 300px;">
                    <strong>Error Message:</strong><br/>
                    ${exception.message}<br/>
                    ${requestScope['jakarta.servlet.error.message']}
                    
                    <hr>
                    <strong>Stack Trace:</strong><br/>
                    <c:forEach items="${exception.stackTrace}" var="trace">
                        ${trace}<br/>
                    </c:forEach>
                </div>
                
                <a href="javascript:history.back()" class="btn btn-primary mt-3">뒤로 가기</a>
                <a href="/" class="btn btn-outline-secondary mt-3">메인으로</a>
            </div>
        </div>
    </div>
</body>
</html>