/* ===============================
 * 숫자 유틸
 * =============================== */
function formatNumber(num) {
  return Number(num).toLocaleString();
}

function unformatNumber(str) {
  return Number(String(str).replace(/,/g, '')) || 0;
}

/* ===============================
 * 지급 버튼 클릭 → 모달 오픈
 * =============================== */
document.addEventListener('click', function (e) {
  const btn = e.target.closest('.btn-pay');
  if (!btn) return;

  const modalEl = document.getElementById('payModal');
  const modal = new bootstrap.Modal(modalEl);

  const vendorId = Number(btn.dataset.vendorId);
  const vendorCode = btn.dataset.vendorCode;
  const vendorName = btn.dataset.vendorName;
  const baseMonth = btn.dataset.baseMonth;
  // 기본 값 세팅
  modalEl.querySelector('[name=vendorId]').value = vendorId;
  modalEl.querySelector('[name=vendorCode]').value = vendorCode;
  modalEl.querySelector('[name=vendorName]').value = vendorName;
  modalEl.querySelector('[name=baseMonth]').value = baseMonth;
  modalEl.querySelector('[name=baseMonthView]').value = baseMonth;

  // 남은금액/지급금액 초기화
  modalEl.querySelector('[name=remainAmount]').value = 0;
  modalEl.querySelector('[name=remainAmountView]').value = formatNumber(0);
  modalEl.querySelector('[name=payAmount]').value = '0';
  modalEl.querySelector('[name=memo]').value = '';

  // 채권 select 초기화
  const select = modalEl.querySelector('#receivableSelect');
  select.innerHTML = `<option value="">채권을 선택하세요</option>`;

  fetch(`/receivable/vendor/receivables?vendorId=${vendorId}&baseMonth=${encodeURIComponent(baseMonth)}`)
    .then(res => {
      if (!res.ok) throw new Error();
      return res.json();
    })
    .then(list => {
      if (!Array.isArray(list) || list.length === 0) {
        // 채권이 없으면 지급 불가 안내
        modalEl.querySelector('[name=remainAmount]').value = 0;
        modalEl.querySelector('[name=remainAmountView]').value = formatNumber(0);
        return;
      }

      list.forEach(r => {
        const option = document.createElement('option');
        option.value = r.receivableId;
        option.dataset.remain = r.remainAmount;

        option.textContent =
          `${r.receivableId}`;

        select.appendChild(option);
      });

      select.selectedIndex = 1;
      const firstRemain = Number(select.options[1].dataset.remain) || 0;
      modalEl.querySelector('[name=remainAmount]').value = firstRemain;
      modalEl.querySelector('[name=remainAmountView]').value = formatNumber(firstRemain);
      modalEl.querySelector('[name=payAmount]').value = '0';
    })
    .catch(() => {
      alert('채권 목록 조회 중 오류가 발생했습니다.');
    });

  modal.show();
});

document.addEventListener('change', function (e) {
  const select = e.target.closest('#receivableSelect');
  if (!select) return;

  const modalEl = document.getElementById('payModal');
  const selected = select.options[select.selectedIndex];
  const remain = Number(selected.dataset.remain) || 0;

  modalEl.querySelector('[name=remainAmount]').value = remain;
  modalEl.querySelector('[name=remainAmountView]').value = formatNumber(remain);

  modalEl.querySelector('[name=payAmount]').value = '0';
});



/* ===============================
 * 금액 버튼 (1만 / 5만 / 10만)
 * =============================== */
document.addEventListener('click', function (e) {
  const btn = e.target.closest('.pay-btn');
  if (!btn) return;

  const form = document.getElementById('payForm');
  const payInput = form.querySelector('[name=payAmount]');

  const current = unformatNumber(payInput.value);
  const add = Number(btn.dataset.amount);
  const remain = unformatNumber(
    form.querySelector('[name=remainAmount]').value
  );

  let next = current + add;
  if (next > remain) {
    next = remain;
  }

  payInput.value = formatNumber(next);
});

/* ===============================
 * 완납 버튼
 * =============================== */
document.getElementById('btnPayAll').addEventListener('click', function () {
  const form = document.getElementById('payForm');
  const remain = unformatNumber(
    form.querySelector('[name=remainAmount]').value
  );

  form.querySelector('[name=payAmount]').value =
    formatNumber(remain);
});

/* ===============================
 * 금액 초기화
 * =============================== */
document.getElementById('btnPayReset').addEventListener('click', function () {
  document
    .getElementById('payForm')
    .querySelector('[name=payAmount]').value = '0';
});

/* ===============================
 * 지급 금액 직접 입력
 * - 숫자만 허용
 * - 콤마 포맷
 * - 남은 금액 초과 방지
 * =============================== */
document
  .querySelector('#payForm [name=payAmount]')
  .addEventListener('input', function () {

    const form = document.getElementById('payForm');
    const remain = unformatNumber(
      form.querySelector('[name=remainAmount]').value
    );

    let value = unformatNumber(this.value);

    if (value > remain) {
      value = remain;
    }

    this.value = formatNumber(value);
  });

/* ===============================
 * 지급 처리
 * =============================== */
document.getElementById('btnPaySubmit').addEventListener('click', function () {

  const form = document.getElementById('payForm');
  const data = new FormData(form); // ✅ 먼저 선언

  const receivableId = data.get('receivableId'); // ✅ 이제 안전

  if (!receivableId) {
    alert('채권을 선택하세요.');
    return;
  }

  const payAmount = unformatNumber(data.get('payAmount'));
  const remain = unformatNumber(data.get('remainAmount'));

  if (payAmount <= 0) {
    alert('지급 금액을 입력하세요.');
    return;
  }

  if (payAmount > remain) {
    alert('지급 금액이 남은 미지급금보다 큽니다.');
    return;
  }

  data.set('payAmount', payAmount);

  fetch('/receivable/hq/pay', {
    method: 'POST',
    body: data
  })
    .then(res => {
      if (!res.ok) throw new Error();
      return res.text();
    })
    .then(() => {
      alert('지급 처리되었습니다.');
      bootstrap.Modal.getInstance(
        document.getElementById('payModal')
      ).hide();
      searchPayables();
    })
    .catch(() => {
      alert('지급 처리 중 오류가 발생했습니다.');
    });
});

