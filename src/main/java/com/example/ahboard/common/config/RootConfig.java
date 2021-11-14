package com.example.ahboard.common.config;

import com.example.ahboard.board.config.BoardRootConfig;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionManager;

import javax.sql.DataSource;

@Configuration
@Import(BoardRootConfig.class)
public class RootConfig {

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource());
        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    public DataSource dataSource(){
        HikariConfig config = new HikariConfig();

        config.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");

        config.setJdbcUrl("jdbc:log4jdbc:mysql://localhost:3306/boarddb");
        config.setUsername("boarddb");
        config.setPassword("boarddb");
        HikariDataSource dataSource = new HikariDataSource(config);
        return dataSource;
    }

    @Bean
    public TransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource());
    }

}
