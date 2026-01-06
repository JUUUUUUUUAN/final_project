package com.cafe.erp.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import jakarta.servlet.DispatcherType;

// 👇 [중요] 반드시 이 경로여야 합니다! (.servlet 확인)
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;

@Configuration
@EnableWebSecurity
public class SecurityConfig { // 클래스명 대문자 (권장)

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring()
                .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                .requestMatchers("/assets/**", "/img/**", "/css/**", "/js/**");
    }
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
            		.dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                    .requestMatchers("/member/login", "/error").permitAll()                    
                    .anyRequest().authenticated()
            )
            .formLogin(login -> login
                    .loginPage("/member/login")
                    .loginProcessingUrl("/member/login")
                    .usernameParameter("memberId")
                    .passwordParameter("memPassword")
                    .defaultSuccessUrl("/member/AM_group_chat", true)
                    .permitAll()
            )
            
            .logout(logout -> logout
                    .logoutUrl("/member/logout")
                    .logoutSuccessUrl("/member/login")
            )
            
            .sessionManagement(session -> session
                    .maximumSessions(1)
                    .maxSessionsPreventsLogin(false)
                    .expiredUrl("/member/login")
            );

        return http.build();
    }
}