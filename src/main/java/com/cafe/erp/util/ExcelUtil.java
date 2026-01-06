package com.cafe.erp.util;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.function.BiConsumer;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import jakarta.servlet.http.HttpServletResponse;

public class ExcelUtil {
	
	@FunctionalInterface
	public interface ExcelRowMapper<T> {
		void map(Row row, T dto);
	}

	/**
     * @param list        다운로드할 데이터 목록 (DTO 리스트)
     * @param headers     엑셀 첫 줄에 들어갈 제목 배열
     * @param fileName    다운로드될 파일 이름
     * @param response    HttpServletResponse 객체
     * @param mapFunction (Row, DTO) -> 엑셀 한 줄을 어떻게 채울지 정의하는 함수
     */
	public static <T> void download(List<T> list, String[] headers, String fileName, HttpServletResponse response, BiConsumer<Row, T> mapFunction) throws IOException {
		try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Sheet1");

            Row headerRow = sheet.createRow(0);
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            int rowNum = 1;
            for (T dto : list) {
                Row row = sheet.createRow(rowNum++);
                mapFunction.accept(row, dto); 
            }
            
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + ".xlsx\"");

            workbook.write(response.getOutputStream());
        }
	}
	
}
